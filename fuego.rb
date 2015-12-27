class Fuego < Formula
  desc "Collection of C++ libraries for the game of Go"
  homepage "http://fuego.sourceforge.net/"
  url "http://svn.code.sf.net/p/fuego/code/trunk", :revision => 1981
  version "1.1.SVN"

  head "http://svn.code.sf.net/p/fuego/code/trunk"

  bottle do
    sha256 "1003e5ae3e78fccc72bd692b016f54024b6fad2af4b6320b812edb22e9378fed" => :yosemite
    sha256 "630d1d66b5681901d3518211e27f2ddd8d41e1681e866c14af41be26f5841e89" => :mavericks
    sha256 "bc778dcbd03afa63e30a049eb982c7c45ec932b273201a878c875c9d0ca2835c" => :mountain_lion
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "boost"

  def install
    system "autoreconf", "-fvi"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
