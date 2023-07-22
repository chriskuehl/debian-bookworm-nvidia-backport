NVIDIA 535 driver backport for Debian Bookworm
====

This repo contains sources to build an unofficial backport of the 535.86.05
NVIDIA driver for Debian Bookworm. It also contains pre-built Debian packages
under GitHub Releases:
https://github.com/chriskuehl/debian-bookworm-nvidia-535-backport/releases

At the time of writing, Debian stable and testing have driver version 525 while
experimental has 530. This backport builds off of the current experimental
release and imports the updated 535 driver from NVIDIA.


## Building

Building takes place inside containers, so you will need to have Podman
installed.

Available build targets:

* `make build`: Build for both amd64 and i386
* `make build-amd64`: amd64 only
* `make build-i386`: i386 only


## Installation

Trying to install these packages via `dpkg -i` is not recommended as it is
tricky to sort through the dependencies by hand, and you may complicate future
upgrades by marking packages as manually installed which makes them harder to
remove later.

Instead, I suggest these steps:

1. Create a directory to hold your packages:

    ```bash
    $ mkdir /opt/nvidia-backport
    ```

2. Copy all of the packages in:

    ```bash
    $ cp dist/{i386,amd64}/*.deb /opt/nvidia-backport
    ```

3. Generate a `Packages` file so this directory can be used as an apt source:

    ```bash
    $ cd /opt/nvidia-backport
    $ dpkg-scanpackages --multiversion . > Packages
    ```

4. Add an entry for this directory to your `/etc/apt/sources.list`:

    ```bash
    $ echo 'deb [trusted=yes] file:/opt/nvidia-backport ./' >> /etc/apt/sources.list
    ```

5. Install the backported packages:

    ```bash
    $ apt update
    $ apt upgrade nvidia-driver
    ```
