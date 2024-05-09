.PHONY: all deps compile format up down test docs shell

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

up:
	docker-compose up -d

down:
	docker-compose down

test:
	mix test

docs:
	mix docs

shell: compile
	iex -S mix
