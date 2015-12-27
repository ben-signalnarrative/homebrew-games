class Stella < Formula
  desc "Atari 2600 VCS emulator"
  homepage "http://stella.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/stella/stella/4.6.7/stella-4.6.7-src.tar.gz"
  sha256 "486e0d1abe30c76216132b042253e2ea12e4039067139603dfde800796f0e650"
  head "http://svn.code.sf.net/p/stella/code/trunk"

  bottle do
    cellar :any
    sha256 "3409555748ab9895e3579bd0b987b54e69b01ca111b9d32f2e2e3af1b9d13b7b" => :el_capitan
    sha256 "dad72240be8f1797885d76ca5e49ee8c6a474bea5a05cfcb402fc79161594424" => :yosemite
    sha256 "5fbaa2329a919c3d8a5ea6b56a7ee8e625bb1432c7ea545907c8a816d75dac3d" => :mavericks
  end

  depends_on :xcode => :build
  depends_on "sdl2"
  depends_on "libpng"

  def install
    cd "src/macosx" do
      inreplace "stella.xcodeproj/project.pbxproj" do |s|
        s.gsub! %r{(\w{24} \/\* SDL2\.framework)}, '//\1'
        s.gsub! %r{(\w{24} \/\* png)}, '//\1'
        s.gsub! /(HEADER_SEARCH_PATHS) = \(/, "\\1 = (#{Formula["sdl2"].include}/SDL2, #{Formula["libpng"].include},"
        s.gsub! /(LIBRARY_SEARCH_PATHS) = \.;/, "\\1 = (#{Formula["sdl2"].lib}, #{Formula["libpng"].lib}, .);"
        s.gsub! /(OTHER_LDFLAGS) = "((-\w+)*)"/, '\1 = "-lSDL2 -lpng \2"'
      end
      xcodebuild "SYMROOT=build"
      prefix.install "build/Default/Stella.app"
      bin.write_exec_script "#{prefix}/Stella.app/Contents/MacOS/Stella"
    end
  end

  test do
    assert_match /Stella version #{version}/, shell_output("#{bin}/Stella -help").strip
  end
end
