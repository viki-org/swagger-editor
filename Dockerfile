FROM viki/node:0.12.9
CMD ["/usr/local/bin/run"]
ADD package.json /tmp/package.json
RUN apt-get update && \
    apt-get install -y nginx-extras nginx && \
    rm -rf /var/cache/apt/* && \
    rm -rf /var/lib/apt/lists/*_* && \
    mkdir -p /opt/swagger-editor && \
    ln -s /opt/swagger-editor/deploy/run /usr/local/bin/run
ADD . /opt/swagger-editor
