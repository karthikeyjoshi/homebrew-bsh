class Bsh < Formula
  desc "High-performance, Git-aware, predictive terminal history middleware"
  homepage "https://github.com/karthikeyjoshi/bsh"
  license "MIT"

  head "https://github.com/karthikeyjoshi/bsh.git", branch: "main"

  
  on_macos do
    if Hardware::CPU.arm?
      # Mac M-Series (Apple Silicon)
      url "https://github.com/karthikeyjoshi/bsh/releases/download/v0.2.6/bsh-macos-arm64.tar.gz"
      sha256 "751fc3be942aa3d5e3fa326fa6c4df1a74195b940966e8b4dec88413a5572837"
    end
    if Hardware::CPU.intel?
      # Mac Intel
      url "https://github.com/karthikeyjoshi/bsh/releases/download/v0.2.6/bsh-macos-x86_64.tar.gz"
      sha256 "4e1285acead6bbc775f7053b13a6995df6b5172e10db0bcee363982e85eb6add"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/karthikeyjoshi/bsh/releases/download/v0.2.6/bsh-linux-x86_64.tar.gz"
      sha256 "10280633e5b0716d06e1001f0d21c50e4ab92f47abdfcc249c31d92cd729b934"
    end
  end


  depends_on "libgit2"

  def install
    bin.install "bin/bsh-daemon"
    
    (share/"bsh").install "scripts/bsh_init.zsh"
  end

  def caveats
    <<~EOS
      To activate BSH, add the following line to the end of your ~/.zshrc:
        source #{opt_share}/bsh/bsh_init.zsh
    EOS
  end
end