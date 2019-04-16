#/var/bin/bash
# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
echo "This install script must be run as root" 1>&2
exit 1
fi


pushd /var/tmp/

if [ -e /bin/bash ] && [ -x "$(command -v dpkg)" ]; then
	echo "1. Download and install dependencies"
	rm -rf gzip_1.10_iphoneos-arm.deb
	rm -rf unrar_5.5.8_iphoneos-arm.deb
	rm -rf bzip2_1.0.6-2_iphoneos-arm.deb
	rm -rf zip_3.0_iphoneos-arm.deb
	rm -rf p7zip_16.02_iphoneos-arm.deb
	rm -rf unzip_6.0_iphoneos-arm.deb
	wget http://tigisoftware.com/rootless/debs/gzip_1.10_iphoneos-arm.deb
	wget http://tigisoftware.com/rootless/debs/unrar_5.5.8_iphoneos-arm.deb
	wget http://tigisoftware.com/rootless/debs/bzip2_1.0.6-2_iphoneos-arm.deb
	wget http://tigisoftware.com/rootless/debs/zip_3.0_iphoneos-arm.deb
	wget http://tigisoftware.com/rootless/debs/p7zip_16.02_iphoneos-arm.deb
	wget http://tigisoftware.com/rootless/debs/unzip_6.0_iphoneos-arm.deb
	dpkg -i gzip_1.10_iphoneos-arm.deb
	dpkg -i unrar_5.5.8_iphoneos-arm.deb
	dpkg -i bzip2_1.0.6-2_iphoneos-arm.deb
	dpkg -i zip_3.0_iphoneos-arm.deb
	dpkg -i p7zip_16.02_iphoneos-arm.deb
	dpkg -i unzip_6.0_iphoneos-arm.deb
	rm -rf gzip_1.10_iphoneos-arm.deb
	rm -rf unrar_5.5.8_iphoneos-arm.deb
	rm -rf bzip2_1.0.6-2_iphoneos-arm.deb
	rm -rf zip_3.0_iphoneos-arm.deb
	rm -rf p7zip_16.02_iphoneos-arm.deb
	rm -rf unzip_6.0_iphoneos-arm.deb
	echo "2. Download Filza File Manager"
	wget http://tigisoftware.com/cydia/com.tigisoftware.filza64bit_3.7.0-18_iphoneos-arm.deb
	echo "3. Install Filza File Manager"
	dpkg -i com.tigisoftware.filza64bit_3.7.0-18_iphoneos-arm.deb
	rm -rf com.tigisoftware.filza64bit_3.7.0-18_iphoneos-arm.deb
	popd
	echo "4. Done"
	echo "5. If you get any installation error, please copy and send to info@tigisoftware.com"
elif [ -e /jb/bin/bash ]
then
	echo "1. Download and install dependencies"
	rm -rf unrar_5.5.8_iphoneos-arm.tar.gz
	rm -rf bzip2_1.0.6-2_iphoneos-arm.tar.gz
	rm -rf zip_3.0_iphoneos-arm.tar.gz
	rm -rf p7zip_16.02_iphoneos-arm.tar.gz
	rm -rf unzip_6.0_iphoneos-arm.tar.gz
	wget http://tigisoftware.com/install/packages/unrar_5.5.8_iphoneos-arm.tar.gz
	wget http://tigisoftware.com/install/packages/bzip2_1.0.6-2_iphoneos-arm.tar.gz
	wget http://tigisoftware.com/install/packages/zip_3.0_iphoneos-arm.tar.gz
	wget http://tigisoftware.com/install/packages/p7zip_16.02_iphoneos-arm.tar.gz
	wget http://tigisoftware.com/install/packages/unzip_6.0_iphoneos-arm.tar.gz
	tar -C /jz/ -xvf unrar_5.5.8_iphoneos-arm.tar.gz
	tar -C /jz/ -xvf bzip2_1.0.6-2_iphoneos-arm.tar.gz
	tar -C /jz/ -xvf zip_3.0_iphoneos-arm.tar.gz
	tar -C /jz/ -xvf p7zip_16.02_iphoneos-arm.tar.gz
	tar -C /jz/ -xvf unzip_6.0_iphoneos-arm.tar.gz
	rm -rf unrar_5.5.8_iphoneos-arm.tar.gz
	rm -rf bzip2_1.0.6-2_iphoneos-arm.tar.gz
	rm -rf zip_3.0_iphoneos-arm.tar.gz
	rm -rf p7zip_16.02_iphoneos-arm.tar.gz
	rm -rf unzip_6.0_iphoneos-arm.tar.gz
	inject /jz/usr/bin/unrar /jz/usr/lib/p7zip/7z /jz/usr/lib/p7zip/7z.so /jz/usr/lib/p7zip/7zCon.sfx /jz/usr/lib/p7zip/7za /jz/usr/lib/p7zip/Codecs/Rar.so /jz/bin/bunzip2 /jz/bin/bzcat /jz/bin/bzip2 /jz/bin/bzip2recover /jz/usr/bin/unzip /jz/usr/bin/unzipsfx /jz/usr/bin/funzip /jz/usr/bin/zip /jz/usr/bin/zip /jz/usr/bin/zipcloak /jz/usr/bin/zipnote /jz/usr/bin/zipsplit
	
	echo "2. Download Filza File Manager"
	wget http://tigisoftware.com/install/packages/com.tigisoftware.filza64bit_3.7.0_bins_iphoneos-arm.tar.gz
	wget http://tigisoftware.com/install/packages/com.tigisoftware.filza64bit_3.7.0_apps_iphoneos-arm.tar.gz
	echo "3. Install Filza File Manager"
	tar -C /jz/ -xvf com.tigisoftware.filza64bit_3.7.0_bins_iphoneos-arm.tar.gz
	tar -C / -xvf com.tigisoftware.filza64bit_3.7.0_apps_iphoneos-arm.tar.gz
	rm -rf com.tigisoftware.filza64bit_3.7.0_apps_iphoneos-arm.tar.gz
	rm -rf com.tigisoftware.filza64bit_3.7.0_bins_iphoneos-arm.tar.gz
	chown -R  root:wheel /jz/Library/LaunchDaemons/com.tigisoftware.filza.helper.plist
	chown -R  root:wheel /jz/usr/libexec
	chown -R  root:admin /Applications/Filza.app
	chmod ug+s /jz/usr/libexec/filza/Filza
	
	inject /Applications/Filza.app/Filza /Applications/Filza.app/dylibs/libsmb2-ios.dylib /Applications/Filza.app/PlugIns/Sharing.appex/Sharing /jz/usr/libexec/filza/Filza /jz/usr/libexec/filza/FilzaHelper /jz/usr/libexec/filza/FilzaWebDAVServer
	
	launchctl unload /jz/Library/LaunchDaemons/com.tigisoftware.filza.helper.plist
	launchctl load -w /jz/Library/LaunchDaemons/com.tigisoftware.filza.helper.plist
	/jb/usr/bin/uicache
	launchctl stop com.apple.backboardd
	popd
	echo "4. Done"
	echo "5. If you get any installation error, please copy and send to info@tigisoftware.com"
elif [ -e /var/bin/bash ]
then
	echo "1. Download and install dependencies"
	rm -rf gzip_1.10_iphoneos-arm.deb
	rm -rf unrar_5.5.8_iphoneos-arm.deb
	rm -rf bzip2_1.0.6-2_iphoneos-arm.deb
	rm -rf zip_3.0_iphoneos-arm.deb
	rm -rf p7zip_16.02_iphoneos-arm.deb
	rm -rf unzip_6.0_iphoneos-arm.deb
	wget http://tigisoftware.com/rootless/debs/gzip_1.10_iphoneos-arm.deb
	wget http://tigisoftware.com/rootless/debs/unrar_5.5.8_iphoneos-arm.deb
	wget http://tigisoftware.com/rootless/debs/bzip2_1.0.6-2_iphoneos-arm.deb
	wget http://tigisoftware.com/rootless/debs/zip_3.0_iphoneos-arm.deb
	wget http://tigisoftware.com/rootless/debs/p7zip_16.02_iphoneos-arm.deb
	wget http://tigisoftware.com/rootless/debs/unzip_6.0_iphoneos-arm.deb
	dpkg -i gzip_1.10_iphoneos-arm.deb
	dpkg -i unrar_5.5.8_iphoneos-arm.deb
	dpkg -i bzip2_1.0.6-2_iphoneos-arm.deb
	dpkg -i zip_3.0_iphoneos-arm.deb
	dpkg -i p7zip_16.02_iphoneos-arm.deb
	dpkg -i unzip_6.0_iphoneos-arm.deb
	rm -rf gzip_1.10_iphoneos-arm.deb
	rm -rf unrar_5.5.8_iphoneos-arm.deb
	rm -rf bzip2_1.0.6-2_iphoneos-arm.deb
	rm -rf zip_3.0_iphoneos-arm.deb
	rm -rf p7zip_16.02_iphoneos-arm.deb
	rm -rf unzip_6.0_iphoneos-arm.deb

	echo "2. Download Filza File Manager"
	wget http://tigisoftware.com/rootless/Filza.app.tar
	wget http://tigisoftware.com/rootless/FilzaBins.tar
	wget http://tigisoftware.com/rootless/com.tigisoftware.filza.helper.plist
	echo "3. Install Filza File Manager"
	mkdir /var/containers/Bundle/tweaksupport/data
	rm -rf /var/containers/Bundle/tweaksupport/data/Filza*
	rm -rf /var/Apps/Filza*
	rm -rf /var/libexec/filza
	rm -rf /var/containers/Bundle/tweaksupport/Library/LaunchDaemons/com.tigisoftware.filza.helper.plist

	tar -xf Filza.app.tar -C /var/Apps/
	mkdir /var/libexec/filza
	tar -xf FilzaBins.tar -C /var/libexec/filza/
	cp -r /var/Apps/Filza.app /var/containers/Bundle/tweaksupport/data/

	/var/containers/Bundle/iosbinpack64/usr/bin/inject /var/Apps/Filza.app/Filza
	/var/containers/Bundle/iosbinpack64/usr/bin/inject /var/Apps/Filza.app/dylibs/libsmb2-ios.dylib
	/var/containers/Bundle/iosbinpack64/usr/bin/inject /var/Apps/Filza.app/PlugIns/Sharing.appex/Sharing
	/var/containers/Bundle/iosbinpack64/usr/bin/inject /var/libexec/filza/Filza
	/var/containers/Bundle/iosbinpack64/usr/bin/inject /var/libexec/filza/FilzaHelper
	/var/containers/Bundle/iosbinpack64/usr/bin/inject /var/libexec/filza/FilzaWebDAVServer


	cp /var/libexec/filza/Filza /var/containers/Bundle/tweaksupport/data/
	cp /var/libexec/filza/FilzaHelper /var/containers/Bundle/tweaksupport/data/
	cp /var/libexec/filza/FilzaWebDAVServer /var/containers/Bundle/tweaksupport/data/

	cp com.tigisoftware.filza.helper.plist /var/containers/Bundle/tweaksupport/Library/LaunchDaemons/com.tigisoftware.filza.helper.plist
	launchctl unload /var/containers/Bundle/tweaksupport/Library/LaunchDaemons/com.tigisoftware.filza.helper.plist
	launchctl load -w /var/containers/Bundle/tweaksupport/Library/LaunchDaemons/com.tigisoftware.filza.helper.plist
	/var/containers/Bundle/iosbinpack64/usr/bin/uicache
	rm -rf Filza.app.tar
	rm -rf FilzaBins.tar
	rm -rf com.tigisoftware.filza.helper.plist
	popd

	echo "4. Done"
	echo "5. If you get any installation error, please copy and send to info@tigisoftware.com"
fi