class Nethack4 < Formula
  desc "Patched, fork version of Nethack"
  homepage "http://nethack4.org"
  url "http://nethack4.org/media/releases/nethack4-4.3-beta2.tar.gz"
  version "4.3.0-beta2"
  sha256 "b143a86b5e1baf55c663ae09c2663b169d265e95ac43154982296a1887d05f15"

  head "http://nethack4.org/media/nethack4.git"

  bottle do
    sha256 "411d26c583596693bde1038256ca2cb7aebe78d4fc60619ee956637119d850b4" => :yosemite
    sha256 "338bb047296ef73889f58a7f9af918a124b3108e4d3c9abd69d381e8b11a2f8b" => :mavericks
    sha256 "7bba1561bc91c10b2098b4bfdba0ca24da9626f19e82fa7ab282e809c15cfddc" => :mountain_lion
  end

  # Assumes C11 _Noreturn is available for clang:
  # http://trac.nethack4.org/ticket/568
  fails_with :clang do
    build 425
  end

  def install
    ENV.refurbish_args

    mkdir "build"
    cd "build" do
      system "../aimake", "--with=jansson", "--without=gui",
        "-i", prefix, "--directory-layout=prefix",
        "--override-directory", "staterootdir=#{var}"
    end
  end

  test do
    system "nethack4", "--version"
  end
end
