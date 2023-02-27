FROM debian:buster

WORKDIR /src

RUN apt update
RUN apt install tree

COPY brhl2030lpr-2.0.1-1.i386.deb /src/

RUN rm -rf /src/content/* /src/content/.*
RUN dpkg -x brhl2030lpr-2.0.1-1.i386.deb content
RUN dpkg-deb -e brhl2030lpr-2.0.1-1.i386.deb content/DEBIAN

WORKDIR /src/content
#RUN tree /src/content && exit 1

RUN mv usr/bin/brprintconflsr2 usr/bin/brprintconflsr2.i386
RUN echo -n '#!/usr/bin/env sh\nexec qemu-i386 /usr/bin/brprintconflsr2.i386 "$@"' > usr/bin/brprintconflsr2
RUN chmod +x usr/bin/brprintconflsr2

RUN mv usr/local/Brother/lpd/rawtobr2 usr/local/Brother/lpd/rawtobr2.i386
RUN echo -n '#!/usr/bin/env sh\nexec qemu-i386 /usr/local/Brother/lpd/rawtobr2.i386 "$@"' > usr/local/Brother/lpd/rawtobr2
RUN chmod +x usr/local/Brother/lpd/rawtobr2

RUN mv usr/local/Brother/inf/braddprinter usr/local/Brother/inf/braddprinter.i386
RUN echo -n '#!/usr/bin/env sh\nexec qemu-i386 /usr/local/Brother/inf/braddprinter.i386 "$@"' > usr/local/Brother/inf/braddprinter
RUN chmod +x usr/local/Brother/inf/braddprinter

RUN sed -i 's/Architecture: i386/Architecture: all/' DEBIAN/control
RUN sed -i 's/Depends: libc6 (>= 2.2.5)/Depends: libc6:i386 (>= 2.2.5), qemu-user (>= 1:2.8)/' DEBIAN/control
RUN find . -type f ! -regex '.*.hg.*' ! -regex '.*?debian-binary.*' ! -regex '.*?DEBIAN.*' -printf '%P ' | xargs md5sum > DEBIAN/md5sums


WORKDIR /src
RUN dpkg-deb -b content brhl2030lpr-2.0.1-1.all.deb
