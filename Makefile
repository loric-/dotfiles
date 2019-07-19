ISO?=ubuntu-18.04.2-desktop-amd64.iso

.PHONY: default
default:
	@echo "select target iso/docker \

.PHONY: iso
iso:
	docker run -it --rm --privileged -v $$(pwd):/root/workdir lobre/isobuilder \
        -p "iso/ks.preseed" \
        -p "iso/isolinux/txt.cfg:isolinux/txt.cfg" \
        -p "iso/scripts" \
        -s "provision/term_root.sh" \
        -s "provision/gui_root.sh" \
        -- $(ISO)
	@[ -f output.iso ] && sudo chown 1000.1000 output.iso

.PHONY: docker
docker:
	docker build -t lobre/dotfiles .

