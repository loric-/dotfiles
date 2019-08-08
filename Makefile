ISO?=ubuntu-18.04.2-desktop-amd64.iso

.PHONY: default
default:
	@echo "select target iso/docker \

.PHONY: iso
iso:
	output="lobre-$$(date +'%Y%m%d%H%M').iso"
	docker run -it --rm --privileged -v $$(pwd):/root/workdir lobre/isobuilder \
        -p "iso/ks.preseed" \
        -p "iso/isolinux/txt.cfg:isolinux/txt.cfg" \
		-p "provision" \
        -s "provision/term_root.sh" \
        -s "provision/gui_root.sh" \
        -f "provision/files/snap.yaml:/var/lib/snapd/seed/seed.yaml" \
        -s "provision/preseed_snap.sh" \
        -s "provision/clean.sh" \
		-o "$$output" \
        -- $(ISO)
	@[ -f "$$output" ] && sudo chown 1000.1000 "$$output"

.PHONY: docker
docker:
	docker build -t lobre/dotfiles .

.PHONY: link
link:
	python3 link.py

.PHONY: term-link
term-link:
	python3 link.py --only-terminal
