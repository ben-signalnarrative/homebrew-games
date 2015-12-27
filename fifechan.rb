class Fifechan < Formula
  desc "C++ GUI library designed for games"
  homepage "https://fifengine.github.io/fifechan/"
  url "https://github.com/fifengine/fifechan/archive/0.1.2.tar.gz"
  sha256 "4a4239314ae33c5413e4d7d3e5f2f1a7e53fb596fd1480ea7443ee78041e6b2d"

  bottle do
    cellar :any
    sha256 "0165e0fe975c0feae8f27029c11282e9d33bb8e9d651f163f890d292f45ae8b2" => :el_capitan
    sha256 "4ff5642e7e98ba6b7aca6b8e8017c82ab81bcb5674ff33386ef7a9cf33144b9a" => :yosemite
    sha256 "15261a2a4a8d7b3b45de748ae724a986511a9c48df6a196207bed60e5d1fdfcb" => :mavericks
  end

  depends_on "cmake" => :build
  depends_on "allegro" => :recommended
  depends_on "sdl" => :recommended
  depends_on "sdl_image" => :recommended

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"fifechan_test.cpp").write <<-EOS
    #include <fifechan.hpp>
    int main(int n, char** c) {
      fcn::Container* mContainer = new fcn::Container();
      if (mContainer == nullptr) {
        return 1;
      }
      return 0;
    }
    EOS

    system ENV.cxx, "-I#{include}", "-L#{lib}", "-lfifechan", "-o", "fifechan_test", "fifechan_test.cpp"
    system "./fifechan_test"
  end
end
