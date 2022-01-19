FROM mcr.microsoft.com/powershell:lts-nanoserver-1809

LABEL author="Julien Creach"
LABEL maintainer="julien.creach@protonmail.com"

USER ContainerAdministrator

SHELL ["pwsh", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Env var redis
RUN $newPath = ('c:\redis;{0}' -f $env:PATH); 	Write-Host ('Updating PATH: {0}' -f $newPath); 	setx /M PATH $newPath;

# Download redis
ARG REDIS_VERSION=3.0.504
ADD https://github.com/microsoftarchive/redis/releases/download/win-${REDIS_VERSION}/Redis-x64-${REDIS_VERSION}.zip redis.zip

# Install redis
RUN Expand-Archive .\redis.zip -DestinationPath c:\redis;
RUN Write-Host 'Verifying install ("redis-server --version") ...';
RUN redis-server --version;

# Clean files
RUN Write-Host 'Removing ...';
RUN Remove-Item .\redis.zip -Force;

# Configuration
RUN (Get-Content c:\redis\redis.windows.conf) 	-Replace '^(bind)\s+.*$', '$1 0.0.0.0' 	-Replace '^(protected-mode)\s+.*$', '$1 no' 	| Set-Content C:\Redis\redis.docker.conf;

# Volumes
VOLUME "c:\data"
WORKDIR "c:\data"

# Ports
EXPOSE 6379/tcp

ENTRYPOINT [ "redis-server.exe" ]
CMD ["c:\\redis\\redis.docker.conf"]
