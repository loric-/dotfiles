ISO?=ubuntu-18.04.2-desktop-amd64.iso

.PHONY: default
default:
	@echo "select target iso/docker \

.PHONY: iso
iso:
	docker run -it --rm --privileged -v $$(pwd):/root/workdir lobre/isobuilder \
        -p "iso/ks.preseed" \
        -p "iso/isolinux/txt.cfg:isolinux/txt.cfg" \
		-p "provision" \
        -s "provision/term_root.sh" \
        -s "provision/gui_root.sh" \
        -f "provision/files/snap.yaml:/var/lib/snapd/seed/seed.yaml" \
        -s "provision/preseed_snap.sh" \
        -s "provision/clean.sh" \
		-o "lobre.iso" \
        -- $(ISO)
	@[ -f lobre.iso ] && sudo chown 1000.1000 lobre.iso

.PHONY: docker
docker:
	docker build -t lobre/dotfiles .

.PHONY: link
link:
	python3 link.py

.PHONY: term-link
term-link:
	python3 link.py --only-terminal
