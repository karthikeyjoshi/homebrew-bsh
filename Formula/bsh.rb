class Bsh < Formula
  desc "High-performance, Git-aware, predictive terminal history middleware"
  homepage "https://github.com/karthikeyjoshi/bsh"
  license "MIT"

  head "https://github.com/karthikeyjoshi/bsh.git", branch: "main"

  
  on_macos do
    if Hardware::CPU.arm?
      # Mac M-Series (Apple Silicon)
      url "https://github.com/karthikeyjoshi/bsh/releases/download/v0.2.7/bsh-macos-arm64.tar.gz"
      sha256 "b787a09fc606880bd3fb4533f8baa2a15cfbeb4dcbea4693965acded02fdb42a"
    end
    if Hardware::CPU.intel?
      # Mac Intel
      url "https://github.com/karthikeyjoshi/bsh/releases/download/v0.2.7/bsh-macos-x86_64.tar.gz"
      sha256 "21d3d4d94fd841932700a8897792e762978aa39ac3613edc6d965bc8eb465a7e"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/karthikeyjoshi/bsh/releases/download/v0.2.7/bsh-linux-x86_64.tar.gz"
      sha256 "1dc213fdea6c52c9f50fdcf80ecb0240d9d7c9cc00a70d2253dff888c0c719ce"
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