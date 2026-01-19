class Morningweave < Formula
  desc "Single-user CLI that builds a scheduled content digest"
  homepage "https://github.com/mbtz/morningweave"
  url "https://github.com/mbtz/morningweave/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "96659556c672e0e8001770c6a2ba9475bb9fcc03694c8f590ec130c876ec1a4b"
  version "1.0.2"
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
