# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..10} )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1

DESCRIPTION="FastAPI framework, high performance, easy to learn, fast to code, ready for production"
HOMEPAGE="https://fastapi.tiangolo.com/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="
        dev-python/starlette[${PYTHON_USEDEP}]
        dev-python/pydantic[${PYTHON_USEDEP}]
        dev-python/ujson[${PYTHON_USEDEP}]
        dev-python/python-email-validator[${PYTHON_USEDEP}]
        dev-python/requests[${PYTHON_USEDEP}]
        dev-python/jinja[${PYTHON_USEDEP}]
        dev-python/itsdangerous[${PYTHON_USEDEP}]
        dev-python/pyyaml[${PYTHON_USEDEP}]
        dev-python/uvicorn[${PYTHON_USEDEP}]
        dev-python/python-multipart[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest