class StoneSoup < Formula
  desc "Dungeon Crawl Stone Soup: a roguelike game"
  homepage "https://crawl.develz.org/"
  url "https://crawl.develz.org/release/stone_soup-0.17.1.tar.xz"
  sha256 "b380f22670a09aab2e433098e2f6bde3a0e15e6b043c711866fb0973f8f3c5a4"

  bottle do
    sha256 "8bd73b526101c1f176fe69833fe02b330507cf99c86294cad12345ed4fe1ffe3" => :el_capitan
    sha256 "79b393921925960335ca95812dc82a52e9ee9d98da25b41f4258c19a2122cf4a" => :yosemite
    sha256 "286e64ece7e56b713afb990c01fde323963784aff1a05e75e55ef6c7b1b02164" => :mavericks
  end

  option "with-tiles", "Enable graphic tiles and sound"

  depends_on "pkg-config" => :build
  depends_on "lua51"
  depends_on "pcre"

  if build.with? "tiles"
    depends_on "sdl2"
    depends_on "sdl2_mixer"
    depends_on "sdl2_image"
    depends_on "libpng"
    depends_on "freetype"
  end

  needs :cxx11

  def install
    ENV.cxx11

    cd "source" do
      args = %W[
        prefix=#{prefix}
        DATADIR=data
        NO_PKGCONFIG=
        BUILD_ZLIB=
        BUILD_LUA=
        BUILD_SQLITE=
        BUILD_FREETYPE=
        BUILD_LIBPNG=
        BUILD_SDL2=
        BUILD_SDL2MIXER=
        BUILD_SDL2IMAGE=
        BUILD_PCRE=
        USE_PCRE=y
      ]
      if build.with? "tiles"
        inreplace "Makefile", "contrib/install/$(ARCH)/lib/libSDL2main.a", ""
        args << "TILES=y"
        args << "SOUND=y"
      end

      # The makefile has trouble locating the developer tools for
      # CLT-only systems, so we set these manually. Reported upstream:
      # https://crawl.develz.org/mantis/view.php?id=7625
      #
      # On 10.9, stone-soup will try to use xcrun and fail due to an empty
      # DEVELOPER_DIR
      devdir = MacOS::Xcode.prefix.to_s
      devdir += "/" if MacOS.version >= :mavericks && !MacOS::Xcode.installed?

      system "make", "install",
        "DEVELOPER_DIR=#{devdir}", "SDKROOT=#{MacOS.sdk_path}",
        # stone-soup tries to use `uname -m` to determine build -arch,
        # which is frequently wrong on OS X
        "SDK_VER=#{MacOS.version}", "MARCH=#{MacOS.preferred_arch}",
        *args
    end
  end

  test do
    assert shell_output("#{bin}/crawl --version").start_with? "Crawl version #{version}"
  end
end
