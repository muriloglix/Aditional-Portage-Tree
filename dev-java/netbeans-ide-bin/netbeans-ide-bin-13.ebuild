# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Apache NetBeans is an open source development environment, tooling platform, and application framework."
HOMEPAGE="https://netbeans.apache.org/"
SRC_URI="https://archive.apache.org/dist/netbeans/netbeans/${PV}/netbeans-${PV}-bin.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm64"

S="${WORKDIR}/netbeans"

IUSE=""

CP_DEPEND=""

RDEPEND=">=virtual/jre-1.8
  ${CP_DEPEND}"
DEPEND=">=virtual/jdk-1.8
  ${CP_DEPEND}"

src_prepare() {
	eapply_user
	sed -i "s/^\(netbeans_default_options\)\(.*\)\(.$\)/\1\2 -J-Dawt.useSystemAAFontSettings=on --locale en_US\3/" etc/netbeans.conf
	sed -i "/#netbeans_jdkhome/anetbeans_jdkhome=\"\$JAVA_HOME\"" etc/netbeans.conf
	default
}

src_compile() {
	true
}

src_install() {
	# fperms +x "${S}/bin/netbeans"
	insinto /opt/netbeans-ide-bin || die
	doins -r "${S}" || die
	dobin ${FILESDIR}/netbeans || die
	# doexe "bin/netbeans"
	# cp -R "${S}/netbeans/" "${D}/opt/netbeans-ide-bin" || die "Install failed!"
}
