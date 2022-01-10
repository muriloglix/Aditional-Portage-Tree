# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_9 )
inherit distutils-r1

DESCRIPTION="A streaming multipart parser for Python"
HOMEPAGE="https://github.com/andrew-d/python-multipart"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="
        dev-python/atomicwrites[${PYTHON_USEDEP}]
        dev-python/attrs[${PYTHON_USEDEP}]
        dev-python/coverage[${PYTHON_USEDEP}]
        dev-python/mock[${PYTHON_USEDEP}]
        dev-python/more-itertools[${PYTHON_USEDEP}]
        dev-python/pbr[${PYTHON_USEDEP}]
        dev-python/pluggy[${PYTHON_USEDEP}]
        dev-python/py[${PYTHON_USEDEP}]
        dev-python/pytest[${PYTHON_USEDEP}]
        dev-python/pyyaml[${PYTHON_USEDEP}]
        dev-python/six[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest