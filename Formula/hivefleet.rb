# Written by scripts/brew-formula.sh in https://github.com/lamplitlabs/hive
# from the SHA256SUMS of the release v0.1.7. The next release writes this file
# again, so a change made here by hand is lost: change the script.
class Hivefleet < Formula
  desc "Self-improving harness for coding agents that runs on your own machines"
  homepage "https://hivefleet.dev"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/lamplitlabs/hive/releases/download/v0.1.7/hive-v0.1.7-aarch64-apple-darwin.tar.gz"
      sha256 "2e528679110fe2373354ba8ea78a3df3fb9fa351bd4ea92c116ad883d857fa06"
    end
    on_intel do
      url "https://github.com/lamplitlabs/hive/releases/download/v0.1.7/hive-v0.1.7-x86_64-apple-darwin.tar.gz"
      sha256 "50403b36d380ff5bee1f27f9c3a06318c9b41d5587928e81d885a56c290bf965"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lamplitlabs/hive/releases/download/v0.1.7/hive-v0.1.7-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e14e25aa6d8a51d725d6139f0975d2e876367f9e51fe14caf35d5b514f0eec1c"
    end
    on_intel do
      url "https://github.com/lamplitlabs/hive/releases/download/v0.1.7/hive-v0.1.7-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "32be7020c2d35e82a0a0dea9cd197f87161010cb7052e4de665597cc2283a80f"
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
