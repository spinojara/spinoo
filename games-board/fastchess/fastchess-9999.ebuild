# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="fastchess is a chess cli tool to run engine vs engine matches"
HOMEPAGE="https://github.com/Disservin/fastchess"

IUSE="+man +zlib"

if [[ ${PV} == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Disservin/${PN}.git"
else
	SRC_URI="https://github.com/Disservin/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS=""

DEPEND="zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}"
BDEPEND="man? ( app-text/lowdown )"

src_compile() {
	local use_zlib

	use zlib && use_zlib="true"

	emake ZLIB="${use_zlib}"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
}
