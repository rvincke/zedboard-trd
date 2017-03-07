ifndef PETALINUX
$(error "Error: PETALINUX environment variable not set.  Change to the root of your PetaLinux install, and source the settings.sh file")
endif

include apps.common.mk

# Set this variable to point to the TRD's prebuilt directory or set environment variable
PETALINUX_REPO = ../../../../../../pre-built

all: build install

build:

clean:

.PHONY: install image

install:
	# Copy cross-compiled executables from repository into target rootfs
	cp -rpP $(PETALINUX_REPO)/bin/* $(TARGETDIR)/usr/bin

help:
	@echo ""
	@echo "Quick reference for various supported build targets for $(INSTANCE)."
	@echo "----------------------------------------------------"
	@echo "  all                    build $(INSTANCE) and install to rootfs host copy"
	@echo "  install                install built objects to rootfs host copy"
