# Written by scripts/brew-formula.sh in https://github.com/lamplitlabs/hive
# from the SHA256SUMS of the release v0.1.8. The next release writes this file
# again, so a change made here by hand is lost: change the script.
class Hivefleet < Formula
  desc "Self-improving harness for coding agents that runs on your own machines"
  homepage "https://hivefleet.dev"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/lamplitlabs/hive/releases/download/v0.1.8/hive-v0.1.8-aarch64-apple-darwin.tar.gz"
      sha256 "3680a8ba9d3852b997d6ca32d72da57b95cdea388de938399efd5209a79a913a"
    end
    on_intel do
      url "https://github.com/lamplitlabs/hive/releases/download/v0.1.8/hive-v0.1.8-x86_64-apple-darwin.tar.gz"
      sha256 "63788695d109662736da9fbf97ce085906ab8bf34d6e850ab110189e057eaaa1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lamplitlabs/hive/releases/download/v0.1.8/hive-v0.1.8-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "dce9485b343225ad5cdd5f892940ca2890149b404c76440bde6a2a2008e87e13"
    end
    on_intel do
      url "https://github.com/lamplitlabs/hive/releases/download/v0.1.8/hive-v0.1.8-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0955e306add8132081f5b94ffd1570c44b7b67ea404e9978b8748b744b2747b3"
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
