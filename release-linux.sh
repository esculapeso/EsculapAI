VERSION=1.0.2.0
rm -rf ./release-linux
mkdir release-linux

cp ./src/esad ./release-linux/
cp ./src/esa-cli ./release-linux/
cp ./src/qt/esa-qt ./release-linux/
cp ./ESACOIN_small.png ./release-linux/

cd ./release-linux/
strip esad
strip esa-cli
strip esa-qt

#==========================================================
# prepare for packaging deb file.

mkdir esacoin-$VERSION
cd esacoin-$VERSION
mkdir -p DEBIAN
echo 'Package: esacoin
Version: '$VERSION'
Section: base 
Priority: optional 
Architecture: all 
Depends:
Maintainer: Esa
Description: Esa coin wallet and service.
' > ./DEBIAN/control
mkdir -p ./usr/local/bin/
cp ../esad ./usr/local/bin/
cp ../esa-cli ./usr/local/bin/
cp ../esa-qt ./usr/local/bin/

# prepare for desktop shortcut
mkdir -p ./usr/share/icons/
cp ../ESACOIN_small.png ./usr/share/icons/
mkdir -p ./usr/share/applications/
echo '
#!/usr/bin/env xdg-open

[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Exec=/usr/local/bin/esa-qt
Name=esacoin
Comment= esa coin wallet
Icon=/usr/share/icons/ESACOIN_small.png
' > ./usr/share/applications/esacoin.desktop

cd ../
# build deb file.
dpkg-deb --build esacoin-$VERSION

#==========================================================
# build rpm package
rm -rf ~/rpmbuild/
mkdir -p ~/rpmbuild/{RPMS,SRPMS,BUILD,SOURCES,SPECS,tmp}

cat <<EOF >~/.rpmmacros
%_topdir   %(echo $HOME)/rpmbuild
%_tmppath  %{_topdir}/tmp
EOF

#prepare for build rpm package.
rm -rf esacoin-$VERSION
mkdir esacoin-$VERSION
cd esacoin-$VERSION

mkdir -p ./usr/bin/
cp ../esad ./usr/bin/
cp ../esa-cli ./usr/bin/
cp ../esa-qt ./usr/bin/

# prepare for desktop shortcut
mkdir -p ./usr/share/icons/
cp ../ESACOIN_small.png ./usr/share/icons/
mkdir -p ./usr/share/applications/
echo '
[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Exec=/usr/bin/esa-qt
Name=esacoin
Comment= esa coin wallet
Icon=/usr/share/icons/ESACOIN_small.png
' > ./usr/share/applications/esacoin.desktop
cd ../

# make tar ball to source folder.
tar -zcvf esacoin-$VERSION.tar.gz ./esacoin-$VERSION
cp esacoin-$VERSION.tar.gz ~/rpmbuild/SOURCES/

# build rpm package.
cd ~/rpmbuild

cat <<EOF > SPECS/esacoin.spec
# Don't try fancy stuff like debuginfo, which is useless on binary-only
# packages. Don't strip binary too
# Be sure buildpolicy set to do nothing

Summary: Esa wallet rpm package
Name: esacoin
Version: $VERSION
Release: 1
License: MIT
SOURCE0 : %{name}-%{version}.tar.gz
URL: https://www.esacoin.net/

BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root

%description
%{summary}

%prep
%setup -q

%build
# Empty section.

%install
rm -rf %{buildroot}
mkdir -p  %{buildroot}

# in builddir
cp -a * %{buildroot}


%clean
rm -rf %{buildroot}


%files
/usr/share/applications/esacoin.desktop
/usr/share/icons/ESACOIN_small.png
%defattr(-,root,root,-)
%{_bindir}/*

%changelog
* Tue Aug 24 2021  Esa Project Team.
- First Build

EOF

rpmbuild -ba SPECS/esacoin.spec



