class Pioneer < Formula
  desc "Game of lonely space adventure"
  homepage "http://pioneerspacesim.net/"
  url "https://github.com/pioneerspacesim/pioneer/archive/20151130.tar.gz"
  sha256 "4dd090a2dea4655bc0726d817fc9079ed1ed18d1845be458db494d55f1949c9a"
  head "https://github.com/pioneerspacesim/pioneer.git"

  bottle do
    sha256 "5319e131e5df8237da4763bacbcb77c660cd5c8c676d94a29271eee1d214fa43" => :el_capitan
    sha256 "d939d1a7f9f2e407c849c59130381b8b37e130307158d8b5144f568377a66eb1" => :yosemite
    sha256 "f27c039521cd5ddb29094c0bc40ff9ad197fd305a6b127662e9c00b6852d4a5b" => :mavericks
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkg-config" => :build
  depends_on "assimp"
  depends_on "freetype"
  depends_on "sdl2"
  depends_on "sdl2_image"
  depends_on "libsigc++"
  depends_on "libvorbis"
  depends_on "libpng"
  depends_on "lua"

  needs :cxx11

  def install
    ENV.cxx11
    ENV["PIONEER_DATA_DIR"] = "#{pkgshare}/data"
    system "./bootstrap"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--with-version=#{version}",
                          "--with-external-liblua"
    system "make", "install"
  end

  test do
    assert_equal "#{name} #{version}", shell_output("#{bin}/pioneer -v 2>&1").chomp
  end
end
