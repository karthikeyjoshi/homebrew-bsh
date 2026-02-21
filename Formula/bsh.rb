class Bsh < Formula
  desc "High-performance, Git-aware, predictive terminal history middleware"
  homepage "https://github.com/karthikeyjoshi/bsh"
  url "https://github.com/karthikeyjoshi/bsh/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "REPLACE_WITH_ACTUAL_SHA256_OF_THE_TAR_GZ"
  license "MIT"

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build

  depends_on "libgit2"

  def install
    system "cmake", "-S", ".", "-B", "build", "-G", "Ninja", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  def caveats
    <<~EOS
      To activate BSH, add the following line to the end of your ~/.zshrc:
        source #{opt_share}/bsh/bsh_init.zsh
      
      Note: If you have existing history, run the import script manually:
        python3 /path/to/repo/import_zsh.py
    EOS
  end

  test do
    assert_predicate bin/"bsh-daemon", :exist?
    assert_predicate bin/"bsh-daemon", :executable?
    
    assert_predicate share/"bsh/bsh_init.zsh", :exist?
  end
end