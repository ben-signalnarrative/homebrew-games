class Angband < Formula
  desc "Dungeon exploration game"
  homepage "http://rephial.org/"
  url "http://rephial.org/downloads/4.0/angband-4.0.4.tar.gz"
  sha256 "93f95444304d5178d23569dbd3dbe1eb29747201d353c676206f26b5bec4667c"
  head "https://github.com/angband/angband.git"

  bottle do
    sha256 "56ecb56fe139b07ad897543ec8bf7e693be274c92bc0ad2c8dace61dda062710" => :el_capitan
    sha256 "1bab68197f12c479006214aa3512a33f93aa195b0c09aefa86b187379463a765" => :yosemite
    sha256 "c7280d8398df5f6de480bae42aac3357f9a911542215511c84d76ef57c7d50b0" => :mavericks
  end

  option "with-cocoa", "Install Cocoa app"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on :x11 => :optional
  depends_on "homebrew/dupes/tcl-tk" => "with-x11" if build.with? :x11
  depends_on "sdl" => :optional
  if build.with? "sdl"
    depends_on "sdl_image"
    depends_on "sdl_ttf"
    depends_on "sdl_mixer" => "with-smpeg"
  end

  def install
    ENV["NCURSES_CONFIG"] = "#{MacOS.sdk_path}/usr/bin/ncurses5.4-config"
    system "./autogen.sh"
    args = %W[
      --prefix=#{prefix}
      --bindir=#{bin}
      --libdir=#{libexec}
      --enable-curses
      --disable-ncursestest
      --disable-sdltest
      --with-ncurses-prefix=#{MacOS.sdk_path}/usr
    ]
    args << "--disable-x11" if build.without? :x11
    args << "--enable-sdl" if build.with? "sdl"

    system "./configure", *args
    system "make"
    system "make", "install"

    if build.with? "cocoa"
      cd "src" do
        system "make", "-f", "Makefile.osx"
      end
      prefix.install "Angband.app"
    end
  end

  test do
    system bin/"angband", "--help"
  end
end
