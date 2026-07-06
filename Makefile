
.PHONY: help analyze-initcall analyze-ftrace summarize-samples build-uart-polling-lab run-uart-polling-lab clean-uart-polling-lab qemu-build-rootfs qemu-build-kernel qemu-direct-boot qemu-bringup-good qemu-bringup-missing-init qemu-bringup-missing-rootfs classify-bringup-logs docker-build docker-shell tree

help:
	@echo "Targets:"
	@echo "  make analyze-initcall  - parse sample initcall_debug log"
	@echo "  make analyze-ftrace    - parse sample ftrace function_graph log"
	@echo "  make summarize-samples - run all sample analyzers"
	@echo "  make build-uart-polling-lab - build UART2 polling terminal lab"
	@echo "  make run-uart-polling-lab   - run UART2 polling terminal lab"
	@echo "  make qemu-build-rootfs      - build minimal arm64 initramfs"
	@echo "  make qemu-build-kernel      - build arm64 Linux Image for QEMU"
	@echo "  make qemu-direct-boot       - boot Image + initramfs in QEMU"
	@echo "  make qemu-bringup-good      - run good QEMU bring-up scenario"
	@echo "  make qemu-bringup-missing-init - run missing init failure scenario"
	@echo "  make qemu-bringup-missing-rootfs - run missing rootfs failure scenario"
	@echo "  make classify-bringup-logs  - classify QEMU bring-up scenario logs"
	@echo "  make docker-build      - build local lab image"
	@echo "  make docker-shell      - open shell in lab image"
	@echo "  make tree              - show repository structure"

analyze-initcall:
	python3 scripts/parse-initcall-debug.py sample-data/initcall/initcall-debug-sample.log

analyze-ftrace:
	python3 scripts/parse-ftrace-function-graph.py sample-data/ftrace/function-graph-sample.trace

summarize-samples: analyze-initcall analyze-ftrace

build-uart-polling-lab:
	$(CC) -Wall -Wextra -std=c11 -O2 -o /tmp/uart2-polling-lab tools/uart2_polling_lab.c

run-uart-polling-lab: build-uart-polling-lab
	/tmp/uart2-polling-lab

clean-uart-polling-lab:
	rm -f /tmp/uart2-polling-lab

qemu-build-rootfs:
	scripts/build-qemu-arm64-initramfs.sh

qemu-build-kernel:
	scripts/build-qemu-arm64-kernel.sh

qemu-direct-boot:
	scripts/run-qemu-aarch64-direct.sh

qemu-bringup-good:
	scripts/run-qemu-bringup-scenario.sh good

qemu-bringup-missing-init:
	scripts/run-qemu-bringup-scenario.sh missing-init

qemu-bringup-missing-rootfs:
	scripts/run-qemu-bringup-scenario.sh missing-rootfs

classify-bringup-logs:
	scripts/classify-bringup-log.py local-artifacts/qemu/bringup-debugging/*.log

tree:
	git ls-files --cached --others --exclude-standard | sort

docker-build:
	docker build -t linux-boot-optimization-lab .

docker-shell:
	docker run --rm -it -v $$PWD:/workspace linux-boot-optimization-lab bash
