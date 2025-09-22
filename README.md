GitLab Runner Image Generator
=============================

This repository contains a [debos](https://github.com/go-debos/debos)
configuration for the generation of a small-ish VM image containing
the [gitlab-runner](https://gitlab.com/gitlab-org/gitlab-runner)
application.

It also contains a bit of configuration to allow jobs to be scheduled to a
[LAVA](https://docs.lavasoftware.org/lava/) instance from inside the runner
jobs, for use in the [Mesa 3D CI pipeline](https://docs.mesa3d.org/ci/LAVA.html)
but that should be easy to remove if not needed.

Building the Image
------------------

The image is built using [`debos`](https://github.com/go-debos/debos) but does
not currently use the native `debos` image building action (see the yaml file
for details).

With a bit of luck you can install debos using:

    $ sudo apt install debos

And build the image files using:

    $ export DEBOS_ARGS="\
         --debug-shell --cpus 10 --scratchsize=8192MB \
        -t gitlab_url:\"https://gitlab.com\" \
        -t gitlab_token:\"glrt-t3_ABCDEFGHIJKLMNOPQRST\" \
        -t lava_url:\"https://lava.pengutronix.de/\" \
        -t lava_token:\"l123456\" \
        -t lava_username:\"gitlab-runner\" \
      "
    $ make

Running the Image
-----------------

See `gitlab-runner.service` for an example on how to run the image in a
qemu VM.

Debugging the Image
-------------------

You can log into the machine to find out what's wrong using:

    $ socat -,rawer,escape=0x1d UNIX-CONNECT:shell.sock

You need to press enter to get an initial prompt.
To exit from the shell, press the CTRL-] escape code.

Change the config and generate a new image once you found out what's wrong!
