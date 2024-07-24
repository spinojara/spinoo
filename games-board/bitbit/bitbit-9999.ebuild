# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A bitboard based chess iengine written in c."
HOMEPAGE="https://github.com/spinojara/bitbit"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cpu_flags_x86_avx2"

if [[ ${PV} == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/spinojara/${PN}.git"
else
	SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
fi

src_compile() {
	local simd

	use cpu_flags_x86_avx2 && simd=avx2

	emake SIMD="${simd}"
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install
}
