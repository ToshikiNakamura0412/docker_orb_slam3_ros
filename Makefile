.PHONY: help setup build

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "  targets:"
	@printf "    setup \e[32m[default]\e[m  create directories for mount\n"
	@echo "    build            build docker image"

setup:
	@if [ -d $(HOME)/bagfiles ]; then echo "$(HOME)/bagfiles already exists"; else mkdir -v $(HOME)/bagfiles; echo "Created $(HOME)/bagfiles"; fi

build:
	@docker compose build
