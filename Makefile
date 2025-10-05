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
	@test -d gen/python/flo_api || (echo "ERROR: gen/python/flo_api not found. Run 'buf generate proto' first." && exit 1)
	# Write a temporary pyproject at repo root and build from here
	printf "%s" "[build-system]\nrequires = [\"setuptools>=61.0\", \"wheel\"]\nbuild-backend = \"setuptools.build_meta\"\n\n[project]\nname = \"flo_api\"\nversion = \"0.1.0a0\"\ndescription = \"Flo API Python stubs\"\nrequires-python = \">=3.9\"\ndependencies = [\"protobuf>=4.25\", \"grpcio>=1.62\", \"googleapis-common-protos>=1.62\"]\n\n[tool.setuptools]\npackages = [\"flo_api\"]\npackage-dir = {\"\" = \"gen/python\"}\n" > pyproject.toml
	python -m build -o dist
	rm -f pyproject.toml

clean:
	rm -rf gen
	rm -rf python/src


