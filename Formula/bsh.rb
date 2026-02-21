class Bsh < Formula
  desc "High-performance, Git-aware, predictive terminal history middleware"
  homepage "https://github.com/karthikeyjoshi/bsh"
  url "https://github.com/karthikeyjoshi/bsh/archive/refs/tags/v0.2.8.tar.gz"
  sha256 "9110213492692db260420567910ee4869d9c01bb894a27be687247ca1dfc95d3"
  license "MIT"

  head "https://github.com/karthikeyjoshi/bsh.git", branch: "main"

  # Build-time dependencies
  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build

  depends_on "libgit2"
  depends_on "sqlitecpp"

  def install
    system "cmake", "-S", ".", "-B", "build", "-G", "Ninja", "-DUSE_SYSTEM_SQLITECPP=ON", *std_cmake_args
    system "cmake", "--build", "build"
    
    bin.install "build/bsh-daemon"
    (share/"bsh").install "scripts/bsh_init.zsh"
    (share/"bsh").install "import_zsh.py"
  end

  def caveats
    <<~EOS
      To activate BSH, add the following line to the end of your ~/.zshrc:
        source #{opt_share}/bsh/bsh_init.zsh
      
      (Optional: If you sync your .zshrc across different OS architectures, use this portable version instead:)
        source $(brew --prefix bsh)/share/bsh/bsh_init.zsh
      
      Note: If you have existing Zsh history, you can import it by running:
        python3 #{opt_share}/bsh/import_zsh.py
    EOS
  end
end