# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Install and Run Python Applications in Isolated Environments"
HOMEPAGE="
	https://pypi.org/project/pipx/
	https://pypa.github.io/pipx/
"
# no tests in sdist
SRC_URI="
	https://github.com/pypa/pipx/archive/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/argcomplete-1.9.4[${PYTHON_USEDEP}]
	>=dev-python/packaging-20.0[${PYTHON_USEDEP}]
	>=dev-python/platformdirs-2.1[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '
		dev-python/tomli[${PYTHON_USEDEP}]
	' 3.10)
	>=dev-python/userpath-1.9.0[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/hatch-vcs[${PYTHON_USEDEP}]
"

PROPERTIES="test_network"
RESTRICT="test"
distutils_enable_tests pytest

export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}

python_test() {
	epytest --net-pypiserver
}
