.PHONY: test

test:
	find . -name '*.dart' | entr -cs 'dart pub run test'

watch:
	find . -name '*.dart' | entr -c aoc

executable:
	dart pub global activate --source path .
