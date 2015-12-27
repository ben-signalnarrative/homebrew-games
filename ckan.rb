class MonoRequirement < Requirement
  fatal true
  default_formula "mono"
  satisfy { which("mono") }
end

class Ckan < Formula
  desc "The Comprehensive Kerbal Archive Network"
  homepage "https://github.com/KSP-CKAN/CKAN/"
  url "https://github.com/KSP-CKAN/CKAN/releases/download/v1.16.0/ckan.exe", :using => :nounzip
  version "1.16.0"
  sha256 "15c0c4a2fe876a560a53d0c706e0398bbc0e8058c355d7fa31e12c66acad4ca0"

  depends_on MonoRequirement

  def install
    (libexec/"bin").install "ckan.exe"
    (bin/"ckan").write <<-EOS.undent
      #!/bin/sh
      exec mono "#{libexec}/bin/ckan.exe" "$@"
    EOS
  end

  test do
    system bin/"ckan", "version"
  end
end
