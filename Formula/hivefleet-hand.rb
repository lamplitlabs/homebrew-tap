# Written by scripts/brew-formula.sh in https://github.com/lamplitlabs/hive
# from the SHA256SUMS of the release v0.1.7. The next release writes this file
# again, so a change made here by hand is lost: change the script.
class HivefleetHand < Formula
  desc "Small program a machine runs to take work from a Hive on another machine"
  homepage "https://hivefleet.dev"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/lamplitlabs/hive/releases/download/v0.1.7/hand-v0.1.7-aarch64-apple-darwin.tar.gz"
      sha256 "297081a558d8306a1473770c85b930f2277be31f26afa526c39e0fde729e7730"
    end
    on_intel do
      url "https://github.com/lamplitlabs/hive/releases/download/v0.1.7/hand-v0.1.7-x86_64-apple-darwin.tar.gz"
      sha256 "59dbe7b6202f3dfddae0550047125879dbd1a8e5384b6fddaf5702bb1b98f211"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/lamplitlabs/hive/releases/download/v0.1.7/hand-v0.1.7-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "13d049f7428ee2f987a8c27c8c1dce7df5e78e8cf60441869050bb242bfc75e8"
    end
    on_intel do
      url "https://github.com/lamplitlabs/hive/releases/download/v0.1.7/hand-v0.1.7-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4ab5ba723b5895aca6591e88d532b1b0ce50998e185e28cb855f835494d091aa"
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
