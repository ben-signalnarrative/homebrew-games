class Ski < Formula
  desc "Evade the deadly Yeti on your jet-powered skis"
  homepage "http://catb.org/~esr/ski/"
  url "http://www.catb.org/~esr/ski/ski-6.9.tar.gz"
  sha256 "d0f2fd7770a63319340fab8ee275c6221dff0e0e7fe488f2298f567583902d37"

  bottle do
    cellar :any
    sha256 "b0ade43d5fc9f2cf1daeddef39b20db8b99501325f8d95fd5737cf848d672d76" => :yosemite
    sha256 "776cb7cf4cd96e64426121362702f00b6ec4766a14f224b125b21e56d90f530c" => :mavericks
    sha256 "5a194977af957429157f86acf8b5e422f8fc293d233954f9e5e520f9a1448acc" => :mountain_lion
  end

  head do
    url "git://thyrsus.com/repositories/ski.git"
    depends_on "xmlto" => :build
  end

  def install
    if build.head?
      ENV["XML_CATALOG_FILES"] = "#{etc}/xml/catalog"
      system "make"
    end
    bin.install "ski"
    man6.install "ski.6"
  end

  test do
    assert_match "Bye!", pipe_output("#{bin}/ski", "")
  end
end
