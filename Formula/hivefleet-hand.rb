# Written by scripts/brew-formula.sh in https://github.com/lamplitlabs/hive
# from the SHA256SUMS of the release v0.1.8. The next release writes this file
# again, so a change made here by hand is lost: change the script.
class HivefleetHand < Formula
  desc "Small program a machine runs to take work from a Hive on another machine"
  homepage "https://hivefleet.dev"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/lamplitlabs/hive/releases/download/v0.1.8/hand-v0.1.8-aarch64-apple-darwin.tar.gz"
      sha256 "88e37cab3b32ba457d7f2fab3529294eb1ad6ee727b2ad71e55e97f460f610dc"
    end
    on_intel do
      url "https://github.com/lamplitlabs/hive/releases/download/v0.1.8/hand-v0.1.8-x86_64-apple-darwin.tar.gz"
      sha256 "9014872fed7dc25841d6a395ef28766456cc7587290741a1878f9ba1deac5136"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lamplitlabs/hive/releases/download/v0.1.8/hand-v0.1.8-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f9387bfd7102b17d675656741270e41877c3b2df6d5b7ae65e863b39ecbd27b6"
    end
    on_intel do
      url "https://github.com/lamplitlabs/hive/releases/download/v0.1.8/hand-v0.1.8-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e635cf14d76a6077564b27bfbe1c49b785b8e835aad5cca6613eabc4277e23c4"
    end
  end

  def install
    # The program goes in libexec with a marker beside it, and bin gets a
    # link. The marker tells the program that Homebrew owns the file, and
    # gives the path that names it from one version to the next.
    libexec.install "hive-hand"
    (libexec/"hive-hand.managed").write <<~EOS
      by=Homebrew
      upgrade=brew upgrade hivefleet-hand
      path=#{opt_bin}/hive-hand
    EOS
    bin.install_symlink libexec/"hive-hand"
  end

  def caveats
    <<~EOS
      Join your Hive with the line its console shows under Machines,
      Add a machine:
        hive-hand join --brain URL CODE

      Upgrade with `brew upgrade hivefleet-hand`.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/hive-hand --version")
    assert_path_exists libexec/"hive-hand.managed"
  end
end
