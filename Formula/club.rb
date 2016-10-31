require File.expand_path("/usr/local/Homebrew/Library/Taps/homebrew/homebrew-php/Abstract/abstract-php-phar", __FILE__)
require File.expand_path("/usr/local/Homebrew/Library/Taps/homebrew/homebrew-php/Requirements/composer-requirement.rb", __FILE__)

class VirtualboxRequirement < Requirement
  fatal true

  satisfy { which("VBoxManage") }

  def message; <<-EOS.undent
    "virtuabox is required to run VM's. Consider running `brew install Caskroom/cask/virtualbox`."
    EOS
  end
end

class VagrantRequirement < Requirement
  fatal true

  satisfy { which("vagrant") }

  def message; <<-EOS.undent
    "vagrant is required to run VM's. Consider running `brew install Caskroom/cask/vagrant`."
    EOS
  end
end

class AnsibleRequirment < Requirement
  fatal false

  satisfy { which("ansible") }

  def message; <<-EOS.undent
    "Ansible greatly speeds up provisioning VMs. Consider running `brew install ansible`."
    EOS
  end
end


class Club < AbstractPhpPhar
  init
  desc "Command-line utility for BLT"
  homepage "https://github.com/acquia/club"
  url "https://github.com/acquia/club/releases/download/0.1/club.phar"
  sha256 "e631e18b1562f62c7e29a490c1c671c7d5c751f4f582aba5cf76895e477d9598"

  depends_on ComposerRequirement
  depends_on VirtualboxRequirement
  depends_on VagrantRequirement
  depends_on AnsibleRequirment

  def install
    bin.install "club.phar" => "club"
  end

  test do
    system "club", "--version"
  end
end
