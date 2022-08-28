# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
SQSHFS_P="squashfs4.3"

inherit flag-o-matic git-r3 toolchain-funcs

DESCRIPTION="The sasquatch project is a set of patches to the standard unsquashfs utility."
HOMEPAGE="https://github.com/devttys0/sasquatch http://squashfs.sourceforge.net"
SRC_URI="mirror://sourceforge/squashfs/${SQSHFS_P}.tar.gz -> ${P}.${SQSHFS_P}.tar.gz"

EGIT_REPO_URI="https://github.com/devttys0/sasquatch"
EGIT_COMMIT="bd864a1b037bf57ca7d64a292a60ba0d6459611f"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

IUSE="debug lz4 lzma lzo xattr zstd xz"

RDEPEND="
	sys-libs/zlib
	lz4? ( app-arch/lz4 )
	lzma? ( app-arch/xz-utils )
	lzo? ( dev-libs/lzo )
	xattr? ( sys-apps/attr )
	zstd? ( app-arch/zstd )
"
DEPEND=${RDEPEND}

S="${WORKDIR}/${SQSHFS_P}/squashfs-tools"

use10() { usex "${1}" 1 0; }

src_unpack() {
	git-r3_src_unpack
	unpack ${A}
}

src_prepare() {
	# Apply debian patches and using upstream...
	# eapply -p2 "${FILESDIR}"/*.patch
	eapply "${WORKDIR}/${P}"/patches/patch0.txt

    sed -e "s/make -C \$(/make CC=$(tc-getCXX) ${MAKEOPTS} -C \$(/" \
		-e "s/-Wall -Werror/-Wall/" \
		-i Makefile || die 'sed failed!'
	
    eapply_user
}


src_configure() {
	# set up make command line variables in EMAKE_SQUASHFS_CONF
	EMAKE_SQUASHFS_CONF=(
        EXTRA_CFLAGS=-fcommon
        LZMA_SUPPORT=$(use10 lzma)
		LZO_SUPPORT=$(use10 lzo)
		LZ4_SUPPORT=$(use10 lz4)
		XATTR_SUPPORT=$(use10 xattr)
        LZMA_XZ_SUPPORT=$(use10 xz)
		XZ_SUPPORT=$(use10 xz)
		ZSTD_SUPPORT=$(use10 zstd)
	)

	tc-export CC
	use debug && append-cppflags -DSQUASHFS_TRACE
}

src_compile() {
	emake "${EMAKE_SQUASHFS_CONF[@]}"
}

src_install() {
    dobin sasquatch
}