# ----------------------------------
# LiteladerBDS Core
# Environment: LiteLoaderBDS
# Minimum Panel Version: 1.x.x
# ----------------------------------
FROM alpine

LABEL Pterodactyl Software, <support@pterodactyl.io>

ENV BDSDIR /home/container/bds/
ENV BDSVER 1.18.2.03
ENV LLVER 2.0.3

RUN apk update
RUN adduser --disabled-password --home /home/container container
RUN apk add wget && apk add unzip
RUN apk add wine && ln -s /usr/bin/wine64 /usr/bin/wine
RUN wget https://minecraft.azureedge.net/bin-win/bedrock-server-${BDSVER}.zip
RUN wget https://github.com/LiteLDev/LiteLoaderBDS/releases/download/${LLVER}/LiteLoader-${LLVER}.zip
RUN wget https://github.com/canhphung/LiteLoaderBDS-Docker-v2/raw/main/vcruntime140_1.zip
RUN unzip bedrock-server-${BDSVER}.zip -d ${BDSDIR}
RUN unzip LiteLoader-${LLVER}.zip -d ${BDSDIR}

    COPY vcruntime140_1.zip ${BDSDIR}
    RUN unzip vcruntime140_1.zip "vcruntime140_1.dll" && \
    rm vcruntime140_1.zip
    
USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
