GitLab Runner Image Generator
=============================

This repository contains a [debos](https://github.com/go-debos/debos)
configuration for the generation of a small-ish VM image.

Building the Image
------------------

The image is built using [`debos`](https://github.com/go-debos/debos) but does
not currently use the native `debos` image building action (see the yaml file
for details).

With a bit of luck you can install debos using:

    $ sudo apt install debos

And build the image files using:

    $ debos --debug-shell --cpus 10 --scratchsize=8192MB \
        gitlab-runner.yaml

Running the Image
-----------------

See `gitlab-runner.service` for an example on how to run the image in a
qemu VM.
