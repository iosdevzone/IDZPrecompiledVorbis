mkdir -p libvorbis/1.3.3
pushd libvorbis/1.3.3
curl -O http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.3.tar.gz
tar xvfz libvorbis-1.3.3.tar.gz

# Phone builds
export IDZ_EXTRA_CONFIGURE_FLAGS=--with-ogg=$IDZ_BUILD_ROOT/libogg/1.3.1/install-iPhoneOS-armv7
idz_configure armv7 7.0 libvorbis-1.3.3/configure
export IDZ_EXTRA_CONFIGURE_FLAGS=--with-ogg=$IDZ_BUILD_ROOT/libogg/1.3.1/install-iPhoneOS-armv7s
idz_configure armv7s 7.0 libvorbis-1.3.3/configure
export IDZ_EXTRA_CONFIGURE_FLAGS=--with-ogg=$IDZ_BUILD_ROOT/libogg/1.3.1/install-iPhoneOS-arm64
idz_configure arm64 7.0 libvorbis-1.3.3/configure

# Simulator build
export IDZ_EXTRA_CONFIGURE_FLAGS=--with-ogg=$IDZ_BUILD_ROOT/libogg/1.3.1/install-iPhoneSimulator-i386
idz_configure i386 7.0 libvorbis-1.3.3/configure
export IDZ_EXTRA_CONFIGURE_FLAGS=--with-ogg=$IDZ_BUILD_ROOT/libogg/1.3.1/install-iPhoneSimulator-x86_64
idz_configure x86_64 7.0 libvorbis-1.3.3/configure

# Combine libraries
pushd install-iPhoneOS-armv7/lib
idz_combine libvorbisall.a *.a
popd
pushd install-iPhoneOS-armv7s/lib
idz_combine libvorbisall.a *.a
popd
pushd install-iPhoneOS-arm64/lib
idz_combine libvorbisall.a *.a
popd
pushd install-iPhoneSimulator-i386/lib
idz_combine libvorbisall.a *.a
popd
pushd install-iPhoneSimulator-x86_64/lib
idz_combine libvorbisall.a *.a
popd

# Create pseudo-framework
idz_fw Vorbis libvorbisall.a install-iPhoneSimulator-i386/include/vorbis

# Back to where we started!
popd
