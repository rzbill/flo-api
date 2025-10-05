SHELL := bash
.ONESHELL:
.PHONY: deps lint gen clean py-wheel

deps:
	buf mod update proto

lint:
	buf lint proto

gen:
	buf generate proto

.PHONY: py-wheel
py-wheel:
	python -m pip install -U pip build
	rm -rf dist
	mkdir -p dist
	@test -d gen/python/flo_api || (echo "ERROR: gen/python/flo_api not found. Run 'buf generate proto' first." >&2; exit 1)
	# Write a temporary pyproject at repo root and build from here
	cat > pyproject.toml <<-'PY'
	[build-system]
	requires = ["setuptools>=61.0", "wheel"]
	build-backend = "setuptools.build_meta"

	[project]
	name = "flo_api"
	version = "0.1.0a0"
	description = "Flo API Python stubs"
	requires-python = ">=3.9"
	dependencies = ["protobuf>=4.25", "grpcio>=1.62", "googleapis-common-protos>=1.62"]

	[tool.setuptools]
	packages = ["flo_api"]
	package-dir = {"" = "gen/python"}
	PY
	python -m build -o dist
	rm -f pyproject.toml

clean:
	rm -rf gen
	rm -rf python/src


