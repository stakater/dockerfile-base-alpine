FROM    alpine:3.4
LABEL   authors="Hazim <hazim_malik@hotmail.com>"

RUN     apk --no-cache add --update bash sudo nano sudo zip bzip2 fontconfig wget

RUN     addgroup stakater && \
        adduser -S -G stakater stakater && \
        adduser -S -G stakater sudo

# Expose the working directory
VOLUME 	["/home/stakater"]

RUN     rm -rf /var/cache/apk/*