# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="deSEC DNS Authenticator plugin for Certbot"
HOMEPAGE="
	https://pypi.org/project/certbot-dns-loopia/
	https://github.com/runfalk/certbot-dns-loopia
"

SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	app-crypt/loopialib[${PYTHON_USEDEP}]
"

RDEPEND="
	app-crypt/certbot[${PYTHON_USEDEP}]
"
BDEPEND="test? (
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/requests-mock[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest

