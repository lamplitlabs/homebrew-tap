# Written by scripts/brew-formula.sh in https://github.com/lamplitlabs/hive
# from the SHA256SUMS of the release v0.1.6. The next release writes this file
# again, so a change made here by hand is lost: change the script.
class HivefleetHand < Formula
  desc "Small program a machine runs to take work from a Hive on another machine"
  homepage "https://hivefleet.dev"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/lamplitlabs/hive/releases/download/v0.1.6/hand-v0.1.6-aarch64-apple-darwin.tar.gz"
      sha256 "5abfd8b07a8d03bf22cf592a0840da0e15522bb3ac0c41596f0b25aa771e2e2f"
    end
    on_intel do
      url "https://github.com/lamplitlabs/hive/releases/download/v0.1.6/hand-v0.1.6-x86_64-apple-darwin.tar.gz"
      sha256 "152ba48951e54001567387596c6897fe2aa9b794bcc8328615e3f55a2a148452"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lamplitlabs/hive/releases/download/v0.1.6/hand-v0.1.6-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2145deb083eb9bbf2c06447d50e830b2a95c29f6e873e522462393a9cfcc53e9"
    end
    on_intel do
      url "https://github.com/lamplitlabs/hive/releases/download/v0.1.6/hand-v0.1.6-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3102bf0d5168196573d09104c89b497eb7a22cb000e411619e1983ab9dd92a2b"
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
