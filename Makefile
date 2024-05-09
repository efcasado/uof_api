.PHONY: all deps compile format test docs shell publish

ifndef NODOCKER
SHELL     := BASH_ENV=.rc /bin/bash --noprofile
endif

all: deps compile check test docs

deps:
	mix deps.get
	mix deps.compile

compile:
	mix compile

format:
	mix format

check:
	mix format --check-formatted

test:
	mix test

docs:
	mix docs

shell: compile
	iex -S mix

publish: deps
	mix local.hex --force
	mix hex.publish --yes --dry-run
