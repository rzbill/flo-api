SHELL := bash
.ONESHELL:
.PHONY: deps lint gen clean

deps:
	buf mod update proto

lint:
	buf lint proto

gen:
	buf generate proto

clean:
	rm -rf gen
	rm -rf python/src


