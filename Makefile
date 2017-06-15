PYTHON=$(shell which python)

LINT_FILES = $(wildcard mio/*.py) \
	$(wildcard iocontrol/*.py)

.PHONY: docs test clean wheel source pylint

all: wheel

pylint:
	pylint --reports=n $(LINT_FILES)

source:
	$(PYTHON) setup.py sdist

wheel: source
	$(PYTHON) setup.py bdist_wheel

docs:
	( cd docs && $(MAKE) html )

test:
	$(PYTHON) -m unittest discover -v

clean:
	rm -f *.pyc mio/*.pyc iocontrol/*.pyc tests/*.pyc
	rm -rf dist build mio.egg-info
	rm -rf docs/_build
