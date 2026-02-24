# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{13..14} )

inherit python-single-r1

DESCRIPTION="A bridge between Lichess bots and chess engines"
HOMEPAGE="https://github.com/lichess-bot-devs/python-chess"

IUSE=""

if [[ ${PV} == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lichess-bot-devs/${PN}.git"
else
	SRC_URI="https://github.com/lichess-bot-devs/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"

DEPEND="
	>=dev-python/python-chess-1.11.2
	>=dev-python/pyyaml-6.0
	>=dev-python/requests-2.32
	>=dev-python/backoff-2.2
	>=dev-python/rich-14.3
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	default
	sed -i '1i #!/usr/bin/env python' lichess-bot.py || die
	sed -i 's/from lib\.lichess_bot/from lichess_bot.lichess_bot/' lichess-bot.py || die
	sed -i -E 's/from lib\.?/from ./g' lib/* extra_game_handlers.py || die
	sed -i 's/from extra_game_handlers/from .extra_game_handlers/' lib/* || die
}

src_install() {
	insinto "$(python_get_sitedir)/lichess_bot"
	doins -r lib/*
	doins extra_game_handlers.py

	python_newscript lichess-bot.py lichess-bot

	python_optimize

	keepdir "/var/lib/lichess-bot"
	newinitd "${FILESDIR}/lichess-bot-openrc.sh" "lichess-bot"
}
