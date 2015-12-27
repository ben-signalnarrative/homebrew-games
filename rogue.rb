class Rogue < Formula
  desc "Dungeon crawling video game"
  homepage "http://rogue.rogueforge.net/"
  url "http://rogue.rogueforge.net/files/rogue5.4/rogue5.4.4-src.tar.gz"
  version "5.4.4"
  sha256 "7d37a61fc098bda0e6fac30799da347294067e8e079e4b40d6c781468e08e8a1"

  def install
    ENV.ncurses_define if MacOS.version >= :snow_leopard

    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"

    inreplace "config.h", "rogue.scr", "#{var}/rogue/rogue.scr"

    inreplace "Makefile" do |s|
      # Take out weird man install script and DIY below
      s.gsub! "-if test -d $(man6dir) ; then $(INSTALL) -m 0644 rogue.6 $(DESTDIR)$(man6dir)/$(PROGRAM).6 ; fi", ""
      s.gsub! "-if test ! -d $(man6dir) ; then $(INSTALL) -m 0644 rogue.6 $(DESTDIR)$(mandir)/$(PROGRAM).6 ; fi", ""
    end

    system "make", "install"
    man6.install gzip("rogue.6")
    libexec.mkpath
    (var/"rogue").mkpath
  end

  test do
    system "#{bin}/rogue", "-s"
  end
end
