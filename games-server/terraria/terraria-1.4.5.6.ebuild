# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{13..14} )

inherit python-single-r1

DESCRIPTION="A bridge between Lichess bots and chess engines"
HOMEPAGE="https://github.com/lichess-bot-devs/python-chess"

IUSE=""

S="${WORKDIR}/${PV//.}"
SRC_URI="https://terraria.org/api/download/pc-dedicated-server/terraria-server-${PV//.}.zip -> ${P}.zip"
KEYWORDS="~amd64"

LICENSE="GPL-2"
SLOT="0"

DEPEND="
	app-misc/dtach
"
RDEPEND="${DEPEND}"
BDEPEND="app-arch/unzip"

src_install() {
	insinto "/opt/${PN}"
	doins -r "Linux/."
	exeinto "/opt/${PN}"
	doexe "Linux/TerrariaServer" "Linux/TerrariaServer.bin.x86_64"

	keepdir "/var/lib/terraria/worlds"
	insinto "/etc/terraria"
	newins "${FILESDIR}/terraria.conf" "server.conf"
	fperms 600 "/etc/terraria/server.conf"
}
