class Supertux < Formula
  desc "Classic 2D jump'n run sidescroller game"
  homepage "http://supertuxproject.org/"
  url "https://github.com/SuperTux/supertux/releases/download/v0.4.0/supertux-0.4.0.tar.bz2"
  sha256 "d18dde3c415e619b4bb035e694ffc384be16576250c9df16929d9ec38daff782"

  bottle do
    cellar :any
    sha256 "e0c4508852c7f695277c568db22aa515b0c86e957126ff3df816b84f9763ff7c" => :el_capitan
    sha256 "009318506dfbfbc1e0b5ae77c5e83ddb49175a4b95d1f9863e7b1a047b3c9fa8" => :yosemite
    sha256 "2eedad9175fdb8d2f4803bcf9e8482b1e73288d946605f06a24990875f596b8b" => :mavericks
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "boost" => :build
  depends_on "sdl2"
  depends_on "sdl2_image"
  depends_on "sdl2_mixer" => "with-libvorbis"
  depends_on "libogg"
  depends_on "libvorbis"
  depends_on "physfs"
  depends_on "glew"

  needs :cxx11

  def install
    ENV.cxx11
    system "cmake", ".", "-DDISABLE_CPACK_BUNDLING=ON", *std_cmake_args
    system "make", "install"
    bin.write_exec_script "#{prefix}/SuperTux.app/Contents/MacOS/supertux2"
    (share/"appdata").rmtree
  end

  test do
    assert_equal "supertux2 v#{version}", shell_output("#{bin}/supertux2 --version").chomp
  end
end
