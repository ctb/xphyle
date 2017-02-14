![https://pypi.python.org/pypi/xphyle](https://img.shields.io/pypi/v/xphyle.svg?branch=master)
![https://travis-ci.org/jdidion/xphyle](https://travis-ci.org/jdidion/xphyle.svg?branch=master)
[![Coverage Status](https://coveralls.io/repos/github/jdidion/xphyle/badge.svg?branch=master)](https://coveralls.io/github/jdidion/xphyle?branch=master)
[![Code Climate](https://codeclimate.com/github/jdidion/xphyle/badges/gpa.svg)](https://codeclimate.com/github/jdidion/xphyle)
[![Documentation Status](https://readthedocs.org/projects/xphyle/badge/?version=latest)](http://xphyle.readthedocs.io/en/latest/?badge=latest)

# xphyle: extraordinarily simple file handling

<img src="https://github.com/jdidion/xphyle/blob/master/docs/logo.png?raw=true"
     alt="logo" width="200" height="200">

xphyle is a small python (3.3+) library that makes it easy to open compressed
files. Most importantly, xphyle will use the appropriate program (e.g. 'gzip') to compress/uncompress a file if it is available on your system; this is almost always faster than using the corresponding python library. xphyle also provides methods that simplify common file I/O operations.

# Installation

```
pip install xphyle
```

If you are using python 3.3 or 3.4, this will install one dependency: [backports.typing](https://pypi.python.org/pypi/backports.typing).

# Building from source

Clone this repository and run

```
make
```

# Example usages:

```python
from xphyle import *
from xphyle.paths import STDIN, STDOUT

# Open a compressed file...
myfile = xopen('infile.gz')

# ...or a compressed stream
# e.g. gzip -c afile | python my_program.py
stdin = xopen(STDIN)

# Easily write to the stdin of a subprocess
with open_('|cat', 'wt') as process:
    process.write('foo')

# We have to tell xopen what kind of compression
# to use when writing to stdout
stdout = xopen(STDOUT, compression='gz')

# Print all lines in a compressed file...
with open_('infile.gz') as myfile:
    for line in myfile:
        print(line)

# ... or a compressed URL
with open_('http://foo.com/myfile.gz') as myfile:
    for line in myfile:
        print(line)

# Transparently handle paths and file objects
def dostuff(path_or_file):
    with open_(path_or_file) as myfile:
        for line in myfile:
            print(line)

# Read all lines in a compressed file into a list
from xphyle.utils import read_lines
lines = list(read_lines('infile.gz'))

# Sum the rows in a compressed file where each line is an integer value
total = sum(read_lines('infile.gz', convert=int))
```

See the [Documentation](http://xphyle.readthedocs.io/en/latest/?badge=latest) for full usage information.

# Roadmap

Future releases are mapped out using [GitHub Projects](https://github.com/jdidion/xphyle/projects).

# Developers

We welcome any contributions via pull requests. Style-wise, we try to adhere to the Google python style guidelines. We use Google-style docstrings, which are formatted by the [Napoleon Sphinx Plugin](https://pypi.python.org/pypi/sphinxcontrib-napoleon). We run pylint as part of each build and strive to maintain a 10/10 score. However, we disable some pylint checks:

* Function annotations: pylint does not properly handle whitespace around function annotations (https://github.com/PyCQA/pylint/issues/238).
* White space on empty lines: we use white space as a visual guide to the structure of the code. Each blank line should have whitespace matching the indent level of the next non-blank line.
* Checks that are arbitrary/overly restrictive (e.g. 'too-many-xxx'; see .pylintrc for full list)
