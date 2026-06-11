.PHONY: all test build run clean

all: test build

test:
	moon test

build:
	moon build

run:
	moon run cmd/fsm-cli

clean:
	moon clean
