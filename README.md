# Multiarch Linux Driver for Brother HL-2030

This is a repack of the original i386 Linux driver for the Brother HL-2030
printer. The original driver is i386 only. This package uses qemu-user to
emulate the included binaries on any arch.

The i386 deb files are **property of Brother** and are unmodified copies of their [driver download page](https://www.brother.de/support/hl-2030/downloads).

## Inspiration

Inspiration was given by the work of 
[https://github.com/alexivkin/brother-in-arms](https://github.com/alexivkin/brother-in-arms).

## Installation (on non-i386 systems)

```bash
dpkg --add-architecture i386
apt update
apt install libc6:i386 qemu-user
dpkg -i brhl2030lpr-2.0.1-1.all.deb
dpkg -i cupswrapperHL2030-2.0.1-2.all.deb
```

## Building

The build was done via docker. Quite strange. But might be reproducable in the
future. Just build the images and extract the new deb file from them.
