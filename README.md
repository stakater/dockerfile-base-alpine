# Base Docker Image based on Alpine

This is an alpine docker image used as base for other docker images in stakater.

Alpine Linux is a Linux distribution built around musl libc and BusyBox. The image is very small in size and has access to a package repository that is much more complete than other BusyBox based images. This makes Alpine Linux a great image base for utilities and even production applications. Read more about Alpine Linux here and you can see how their mantra fits in right at home with Docker images.


How to run:
```
docker run -it --rm stakater/alpine /bin/bash
```

To add any service daemons, you can create `runit` entries. Just write a shell script and add it to `/etc/services` like `/etc/services/myDaemon/run`. Where `myDaemon` is the name of your daemon and the script should be placed by the name `run`.
Runit will be responsible for keeping your daemon running.