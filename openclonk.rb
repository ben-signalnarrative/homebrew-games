class Openclonk < Formula
  desc "Multiplayer action game"
  homepage "http://www.openclonk.org"
  url "https://github.com/openclonk/openclonk/archive/v6.1.tar.gz"
  sha256 "4e2e6cefedd4a13523593b285af23b530caa3a98ff02ac4adb215cf32889cb94"
  head "https://github.com/openclonk/openclonk", :using => :git

  bottle do
    cellar :any
    sha256 "bab95c703bf739aa824087a2d7e74e6cb2ba39820d5579b4b844b278ed2ce312" => :yosemite
    sha256 "78db1e1d29ff023e2bdf2c9a1e1cbee9793664c4ec42f9a6c2f017580c7a5ceb" => :mavericks
    sha256 "522ebcef7cc4a6597f7593b976827b0409612f483e48df4876294e0de40a8119" => :mountain_lion
  end

  depends_on :macos => :mountain_lion
  depends_on "cmake" => :build
  depends_on "jpeg"
  depends_on "libpng"
  depends_on "freetype"
  depends_on "glew"
  depends_on "libogg"
  depends_on "libvorbis"
  depends_on "boost"
  depends_on "freealut"

  needs :cxx11

  def install
    ENV.cxx11
    system "cmake", ".", *std_cmake_args
    system "make"
    system "make", "install"
  end
end
