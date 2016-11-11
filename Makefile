build:
	python setup.py install && nose2 -C tests --coverage-report term-missing --coverage-config .coveragerc

release:
	# tag
	git tag $version
	# build
	python setup.py install
	nose2 -C tests --coverage-report term-missing --coverage-config .coveragerc
	python setup.py sdist bdist_wheel
	# release
	twine register dist/xphyle-${version}.tar.gz
	twine upload dist/xphyle-${version}.tar.gz

readme:
	pandoc --from=markdown --to=rst --output=README.rst README.md
