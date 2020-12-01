.PHONY: test

test:
	find . -name '*.dart' | entr -cs 'dart pub run test'

aoc:
	find . -name '*.dart' | entr -c aoc

analyze:
	find . -name '*.dart' | entr -cs 'dart analyze .'

executable:
	dart pub global activate --source path .
