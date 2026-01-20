class Morningweave < Formula
  desc "Single-user CLI that builds a scheduled content digest"
  homepage "https://github.com/mbtz/morningweave"
  url "https://github.com/mbtz/morningweave/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "bbae6c1b07696c8195c4a090fcce9e965eb08894e1a22eed6be0ef755165d25b"
  version "1.1.0"
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
