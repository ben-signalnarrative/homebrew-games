class Liblcf < Formula
  desc "Library for RPG Maker 2000/2003 games data"
  homepage "https://easy-rpg.org/"
  url "https://github.com/EasyRPG/liblcf/archive/0.3.2.tar.gz"
  sha256 "cf98a43f3f10047bf51e92a472bae2904eb61eb7d9495130e17857324047f529"
  head "https://github.com/EasyRPG/liblcf.git"
  revision 1

  bottle do
    cellar :any
    sha256 "0c8f5488254c7afb21ce9739623ee4cd39df8c557d9f2a884636709ed2f6fdba" => :el_capitan
    sha256 "502bb44f623a97305cc1f823f87cad2f4d732889ecfe63c1c6a1a8291a86d954" => :yosemite
    sha256 "3f567a9e11a21c2c6705019091d60ee9752360ffb4267e57bf85dad9da086fca" => :mavericks
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "icu4c"
  depends_on "expat"

  def install
    system "autoreconf", "-i"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "check"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<-EOS.undent
      #include "lsd_reader.h"
      #include <cassert>

      int main() {
        std::time_t const current = std::time(NULL);
        assert(current == LSD_Reader::ToUnixTimestamp(LSD_Reader::ToTDateTime(current)));
        return 0;
      }
    EOS
    system ENV.cc, "test.cpp", "-I#{include}/liblcf", "-L#{lib}", "-llcf", "-o", "test"
    system "./test"
  end
end
