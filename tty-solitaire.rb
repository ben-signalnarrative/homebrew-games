class TtySolitaire < Formula
  desc "Ncurses-based klondike solitaire game"
  homepage "https://github.com/mpereira/tty-solitaire"
  url "https://github.com/mpereira/tty-solitaire/archive/v0.2.0.tar.gz"
  sha256 "9d47c5a88b3d70d19acfdff29532896b7905e9ddc20b29730e3a8cb92ff3cca4"

  bottle do
    cellar :any
    sha256 "20646ef6b93da06b830c00390a5942a44995c1f64680a8cdeeeeeaff610a6dd1" => :yosemite
    sha256 "cfad5566ef6677f0e64b870dd6fc686dcbfe0ffe2d0f0dc0bf10aad804e9ef64" => :mavericks
    sha256 "d827667238329aa0e9071f97114e5f2fba2583c7a5b7c54945af8aa120a25398" => :mountain_lion
  end

  def install
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system "#{bin}/ttysolitaire", "-h"
  end
end
