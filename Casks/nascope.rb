# Updated by the release workflow of buszi/nascope: it rewrites `version` and `sha256` after each release.
cask "nascope" do
  version "1.1.1"
  sha256 "9087a2184e14e813c6f2d7e2bfba570c1f6720da3cc8cb316c79ae17cfb6b7ff"

  url "https://github.com/buszi/nascope/releases/download/v#{version}/Nascope-#{version}.dmg"
  name "Nascope"
  desc "Live telemetry for your NAS from a Glances server"
  homepage "https://github.com/buszi/nascope"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The dmg bundles an Apple Silicon runtime.
  depends_on arch: :arm64

  app "Nascope.app"

  # The app is ad-hoc signed, not notarized: without this Gatekeeper blocks the first launch
  # ("Open Anyway" in System Settings is the manual alternative, see the README).
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Nascope.app"]
  end

  zap trash: "~/Library/Application Support/nascope"
end
