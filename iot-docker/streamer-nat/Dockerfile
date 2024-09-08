FROM alpine:latest

ARG UID="1000"
ARG GID="1000"

RUN apk update && \
    apk add wget && \
    apk add vlc && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /opt/vlc-media && \
    addgroup --g "${GID}" -S vlc && \
    adduser -h /opt/vlc-media -s /bin/sh -u "${UID}" -G vlc -S vlc && \
    chown vlc:vlc -R /opt/vlc-media

EXPOSE 8080
EXPOSE 554
EXPOSE 8554

WORKDIR /opt/vlc-media

# Copy the start script into the container
COPY start.sh /opt/vlc-media/start.sh

# Switch to root to change permissions
USER root
RUN chmod +x /opt/vlc-media/start.sh

# Switch back to the vlc user
USER "vlc"

# Use the script as the entrypoint
ENTRYPOINT [ "/opt/vlc-media/start.sh" ]
