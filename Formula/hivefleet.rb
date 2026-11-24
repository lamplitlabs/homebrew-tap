# Written by scripts/brew-formula.sh in https://github.com/lamplitlabs/hive
# from the SHA256SUMS of the release v0.1.6. The next release writes this file
# again, so a change made here by hand is lost: change the script.
class Hivefleet < Formula
  desc "Self-improving harness for coding agents that runs on your own machines"
  homepage "https://hivefleet.dev"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/lamplitlabs/hive/releases/download/v0.1.6/hive-v0.1.6-aarch64-apple-darwin.tar.gz"
      sha256 "06ed895cb714ce88ec8dc9ed3f1f76b2bc44916012d85c1f008f1982b5c9ab86"
    end
    on_intel do
      url "https://github.com/lamplitlabs/hive/releases/download/v0.1.6/hive-v0.1.6-x86_64-apple-darwin.tar.gz"
      sha256 "60360bd9971e98dc89ee4ad43067f9805c473566a42ff747f46e41bfd11f12a6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lamplitlabs/hive/releases/download/v0.1.6/hive-v0.1.6-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "239d8b78cf624c6ce5bce8fceeab5bfd0aeb464a8b7c31253888941e29ca2695"
    end
    on_intel do
      url "https://github.com/lamplitlabs/hive/releases/download/v0.1.6/hive-v0.1.6-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1aba4999dc67167960368eca2b9f951e8322b9c5c89b1f006c6531070c91ee66"
    end
  end

  conflicts_with "hive", because: "both install a `hive` program"

  def install
    # The program goes in libexec with a marker beside it, and bin gets a
    # link. The marker tells the program that Homebrew owns the file, and
    # gives the path that names it from one version to the next.
    libexec.install "hive"
    (libexec/"hive.managed").write <<~EOS
      by=Homebrew
      upgrade=brew upgrade hivefleet
      path=#{opt_bin}/hive
    EOS
    bin.install_symlink libexec/"hive"
  end

  def caveats
    <<~EOS
      Start the console:
        hive hub

      Upgrade with `brew upgrade hivefleet`. `hive update` does not replace
      a hive that Homebrew installed.
    EOS
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/hive version")
    assert_path_exists libexec/"hive.managed"
  end
end
