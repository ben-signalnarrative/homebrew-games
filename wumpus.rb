class Wumpus < Formula
  desc "Exact clone of the ancient BASIC Hunt the Wumpus game"
  homepage "http://www.catb.org/~esr/wumpus/"
  url "http://www.catb.org/~esr/wumpus/wumpus-1.6.tar.gz"
  sha256 "965e49b3e53f44023994b42b3aa568ad79d3a2287bb0a07460b601500c9ae16d"

  bottle do
    cellar :any
    sha256 "d3b2684fa7a1a7a9c676bc0f7d635ed3913f6734c7810f0c6fa234044ca9a147" => :yosemite
    sha256 "cb277b7dab8ca78ea627f80a9596807b7cd5e8bbba389d0117b4a743bdfdaacf" => :mavericks
    sha256 "c92ce6674f45ee484435cfd5746b4c6ae80d8ced9a5901e254b7e5bacadc8726" => :mountain_lion
  end

  # Patches to allow `make install` to specify a prefix; both patches
  # can be removed in the next release
  patch do
    url "http://thyrsus.com/gitweb/?p=wumpus.git;a=patch;h=ea272d4786a55dbaa493d016324b7a05b4f165b9"
    sha256 "33730ae3874fe8cafd05ddd1a0280ba72d05f2eabbd9ffc6549eeff53b4a9963"
  end
  patch do
    url "http://thyrsus.com/gitweb/?p=wumpus.git;a=patch;h=99022db86e54c3338d6a670f219a0845fd531530"
    sha256 "43beee9e6bbe42f351b7eabe91d4453d9aadd12a5a5f7f32bcc977cafbb23c13"
  end

  def install
    system "make"
    system "make", "prefix=#{prefix}", "install"
  end

  test do
    assert_match("HUNT THE WUMPUS",
                 pipe_output(bin/"wumpus", "^C"))
  end
end
