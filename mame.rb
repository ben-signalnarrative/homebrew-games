class Mame < Formula
  desc "Multiple Arcade Machine Emulator"
  homepage "http://mamedev.org/"
  url "https://github.com/mamedev/mame/archive/mame0168.tar.gz"
  version "0.168"
  sha256 "3b6db52ddffed867ae171664e327f0b2bade64139d3450dc7166c4f90b6d94e8"
  head "https://github.com/mamedev/mame.git"

  bottle do
    cellar :any
    sha256 "122be0ced02907d7f5e728fda7613b6d299ee866f41849a3cf961429c97a8df5" => :el_capitan
    sha256 "38e7e09c627bed7519f4323d8475076c5636715a1f6a1a4b8f71aca9b495f1ef" => :yosemite
    sha256 "01a5f5535c52d1ca4a4533fcb673473e824b619603f445a4e0a4503cbc9e008f" => :mavericks
  end

  depends_on :python => :build if MacOS.version <= :snow_leopard
  depends_on "sdl2"
  depends_on "jpeg"
  depends_on "flac"
  depends_on "sqlite"
  depends_on "portmidi"

  def install
    inreplace "scripts/src/main.lua", /(targetsuffix) "\w+"/, '\1 ""'
    system "make", "PTR64=#{MacOS.prefer_64_bit? ? 1 : 0}", # for old Macs
                   "MACOSX_USE_LIBSDL=1",
                   "USE_SYSTEM_LIB_EXPAT=", # brewed version not picked up
                   "USE_SYSTEM_LIB_ZLIB=1",
                   "USE_SYSTEM_LIB_JPEG=1",
                   "USE_SYSTEM_LIB_FLAC=1",
                   "USE_SYSTEM_LIB_LUA=", # lua53 not available yet
                   "USE_SYSETM_LIB_SQLITE3=1",
                   "USE_SYSTEM_LIB_PORTMIDI=1",
                   "USE_SYSTEM_LIB_PORTAUDIO=1" # currently not used yet
    bin.install "mame"
    man6.install "src/osd/sdl/man/mame.6"
    doc.install Dir["docs/*"]
    pkgshare.install %w[artwork hash keymaps samples]
    (pkgshare/"shader").install Dir["src/osd/modules/opengl/shader/*.[vf]sh"]
  end

  test do
    assert shell_output("#{bin}/mame -help").start_with? "M.A.M.E. v#{version}"
    system "#{bin}/mame", "-validate"
  end
end
