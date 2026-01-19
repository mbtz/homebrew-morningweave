class Morningweave < Formula
  desc "Single-user CLI that builds a scheduled content digest"
  homepage "https://github.com/mbtz/morningweave"
  url "https://github.com/mbtz/morningweave/archive/refs/tags/v1.0.3.tar.gz"
  sha256 "356170660b098c3e9be6441a64f824be3f1062c89e0bd2b3c2d5bbc8c66b243b"
  version "1.0.3"
  head "https://github.com/mbtz/morningweave.git", branch: "main"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    ENV["GOFLAGS"] = "-buildvcs=false"

    ldflags = "-s -w -X morningweave/internal/cli.Version=#{version}"
    system "go", "build", "-trimpath", "-ldflags", ldflags,
           "-o", bin/"morningweave", "./cmd/morningweave"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/morningweave --version").strip
  end
end
