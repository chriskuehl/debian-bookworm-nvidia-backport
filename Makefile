VERSION := 535.86.05

.PHONY: build
build: build-amd64 build-i386

.PHONY: build-%
build-%: nvidia-graphics-drivers/amd64/NVIDIA-Linux-x86_64-$(VERSION).run cook-image-%
	mkdir -p dist/$*
	podman run --arch=$* \
		-v $(CURDIR):/source:ro \
		-v $(CURDIR)/dist/$*:/dist:rw \
		nvidia-build \
		/source/build.sh

.PHONY: cook-image
cook-image-%:
	podman build --arch=$* -t nvidia-build .

nvidia-graphics-drivers/amd64/NVIDIA-Linux-x86_64-$(VERSION).run:
	wget -O $@ https://us.download.nvidia.com/XFree86/Linux-x86_64/$(VERSION)/NVIDIA-Linux-x86_64-$(VERSION).run
