.PHONY: test

aoc:
	find . -name '*.dart' | entr -c aoc

test:
	find . -name '*.dart' | entr -cs 'dart pub run test'

analyze:
	find . -name '*.dart' | entr -cs 'dart analyze .'

executable:
	dart pub global activate --source path .
