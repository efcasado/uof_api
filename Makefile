.PHONY: all deps clean compile format check test coveralls docs shell publish

all: deps compile check test docs

deps:
	mix deps.get
	mix deps.compile

clean:
	mix clean

compile:
	mix compile --warnings-as-errors

format:
	mix format

check:
	mix format --check-formatted

test:
	mix test --warnings-as-errors

coveralls:
	mix coveralls.html --warnings-as-errors

docs:
	mix docs

shell: compile
	iex -S mix

publish: deps
	mix local.hex --force
	mix hex.publish --yes
