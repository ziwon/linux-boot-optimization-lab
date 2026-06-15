
.PHONY: help analyze-initcall analyze-ftrace summarize-samples docker-build docker-shell tree

help:
	@echo "Targets:"
	@echo "  make analyze-initcall  - parse sample initcall_debug log"
	@echo "  make analyze-ftrace    - parse sample ftrace function_graph log"
	@echo "  make summarize-samples - run all sample analyzers"
	@echo "  make docker-build      - build local lab image"
	@echo "  make docker-shell      - open shell in lab image"
	@echo "  make tree              - show repository structure"

analyze-initcall:
	python3 scripts/parse-initcall-debug.py sample-data/initcall/initcall-debug-sample.log

analyze-ftrace:
	python3 scripts/parse-ftrace-function-graph.py sample-data/ftrace/function-graph-sample.trace

summarize-samples: analyze-initcall analyze-ftrace

tree:
	git ls-files --cached --others --exclude-standard | sort

docker-build:
	docker build -t linux-boot-optimization-lab .

docker-shell:
	docker run --rm -it -v $$PWD:/workspace linux-boot-optimization-lab bash
