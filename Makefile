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
	 mkdir -p dist gen/python
	 # write minimal pyproject for packaging gen/python/flo_api
	 mkdir -p gen/python
	 echo "[build-system]\nrequires = [\"setuptools>=61.0\", \"wheel\"]\nbuild-backend = \"setuptools.build_meta\"\n\n[project]\nname = \"flo_api\"\nversion = \"0.1.0a0\"\ndescription = \"Flo API Python stubs\"\nrequires-python = \">=3.9\"\ndependencies = [\"protobuf>=4.25\", \"grpcio>=1.62\", \"googleapis-common-protos>=1.62\"]\n\n[tool.setuptools]\npackages = [\"flo_api\"]\npackage-dir = {\"\" = \"gen/python\"}\n" > gen/python/pyproject.toml
	 python -m build gen/python -o dist

clean:
	rm -rf gen
	rm -rf python/src


