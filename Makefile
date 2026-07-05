
.PHONY: help analyze-initcall analyze-ftrace summarize-samples build-uart-polling-lab run-uart-polling-lab clean-uart-polling-lab docker-build docker-shell tree

help:
	@echo "Targets:"
	@echo "  make analyze-initcall  - parse sample initcall_debug log"
	@echo "  make analyze-ftrace    - parse sample ftrace function_graph log"
	@echo "  make summarize-samples - run all sample analyzers"
	@echo "  make build-uart-polling-lab - build UART2 polling terminal lab"
	@echo "  make run-uart-polling-lab   - run UART2 polling terminal lab"
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

tree:
	git ls-files --cached --others --exclude-standard | sort

docker-build:
	docker build -t linux-boot-optimization-lab .

docker-shell:
	docker run --rm -it -v $$PWD:/workspace linux-boot-optimization-lab bash
