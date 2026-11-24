# Homebrew tap for Hive

[Hive](https://hivefleet.dev) is an open-source harness for coding agents. It
runs on your own machine as one program. This repository holds its Homebrew
formulae.

## Install

```sh
brew install lamplitlabs/tap/hivefleet
```

That installs the program `hive`. The formula is called `hivefleet`, after
the site, because Homebrew's own list already has a `hive` (Apache Hive).
Then:

```sh
hive version
hive hub        # the console, at http://127.0.0.1:8765
```

On a machine that only takes work from your Hive, install the small program
`hive-hand` instead:

```sh
brew install lamplitlabs/tap/hivefleet-hand
```

The formulae are for macOS and Linux, on arm64 and x86_64. Nothing is built
on your machine: Homebrew downloads the archive of the release and checks it
against the SHA-256 written in the formula.

## Upgrade

```sh
brew upgrade hivefleet
```

## Where the formulae come from

The release workflow of [lamplitlabs/hive](https://github.com/lamplitlabs/hive)
writes `Formula/hivefleet.rb` and `Formula/hivefleet-hand.rb` for every
release, from the release's `SHA256SUMS`. A change made here by hand is lost
with the next release: change `scripts/brew-formula.sh` in that repository.

Questions and problems go to
[its issues](https://github.com/lamplitlabs/hive/issues). The page about
releases says more:
[Homebrew](https://hivefleet.dev/docs/release/#homebrew).
