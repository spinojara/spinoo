# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{13..14} )

inherit distutils-r1

DESCRIPTION="A test server for bitbit"
HOMEPAGE="https://github.com/spinojara/testbit"

IUSE=""

if [[ ${PV} == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/spinojara/${PN}.git"
else
	SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

DEPEND="
	dev-python/aiohttp
	dev-python/docker
"
RDEPEND="${DEPEND}"
BDEPEND=""

python_install_all() {
	distutils-r1_python_install_all
	keepdir "/var/lib/bitbit/backup"
	keepdir "/var/lib/bitbit/private"
	newinitd "${S}/testbitd-openrc.sh" testbitd
	newinitd "${S}/testbitn-openrc.sh" testbitn
}
