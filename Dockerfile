FROM    alpine:3.4
LABEL   authors="Hazim <hazim_malik@hotmail.com>"

RUN     apk --no-cache add --update bash sudo nano sudo zip bzip2 fontconfig wget curl

# Download and install runit
RUN     buildDeps='tar make gcc musl-dev' \
        RUNIT_VERSION="2.1.2" \
        RUNIT_DOWNLOAD_URL="http://smarden.org/runit/runit-2.1.2.tar.gz" \
        RUNIT_DOWNLOAD_SHA1="398f7bf995acd58797c1d4a7bcd75cc1fc83aa66" \
        && set -x \
        && apk add --update $buildDeps \
        && curl -sSL "$RUNIT_DOWNLOAD_URL" -o runit.tar.gz \
        && echo "$RUNIT_DOWNLOAD_SHA1 *runit.tar.gz" | sha1sum -c - \
        && mkdir -p /usr/src/runit \
        && tar -xzf runit.tar.gz -C /usr/src/runit --strip-components=2 \
        && rm -f runit.tar.gz \
        && cd /usr/src/runit/src \
        && make \
        && cd .. \
        && cat package/commands | xargs -I {} mv -f src/{} /sbin/ \
        && cd / \
        && rm -rf /usr/src/runit \
        && apk del $buildDeps \
        && sudo mkdir -p /etc/service

RUN     addgroup stakater && \
        adduser -S -G stakater stakater && \
        adduser -S -G stakater sudo

# Expose the working directory
VOLUME 	["/home/stakater"]

RUN     rm -rf /var/cache/apk/*

CMD     ["sh", "-c", "exec runsvdir -P /etc/service/"]