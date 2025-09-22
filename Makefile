DATE := $(shell date +%Y%m%d)
DEBOS ?= debos
DEBOS_ARGS ?=

all: fairytux2-debian.simg

tarballs/debootstrap-$(DATE).tar.gz: steps/debootstrap.yaml
	mkdir -p tarballs
	${DEBOS} ${DEBOS_ARGS}  -t "output_tarball:$@" "$<"

tarballs/early.tar.gz: tarballs/debootstrap-$(DATE).tar.gz steps/early.yaml
	${DEBOS} ${DEBOS_ARGS} -t "input_tarball:$<" -t "output_tarball:$@" steps/early.yaml

tarballs/userspace.tar.gz: tarballs/early.tar.gz steps/userspace.yaml
	${DEBOS} ${DEBOS_ARGS} -t "input_tarball:$<" -t "output_tarball:$@" steps/userspace.yaml

fairytux2-debian.simg: tarballs/userspace.tar.gz steps/image.yaml
	${DEBOS} ${DEBOS_ARGS} -t "input_tarball:$<" steps/image.yaml
