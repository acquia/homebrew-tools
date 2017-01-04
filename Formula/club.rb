require File.expand_path("#{HOMEBREW_REPOSITORY}/Library/Taps/homebrew/homebrew-php/Abstract/abstract-php-phar.rb", __FILE__)
require File.expand_path("#{HOMEBREW_REPOSITORY}/Library/Taps/homebrew/homebrew-php/Requirements/composer-requirement.rb", __FILE__)




class HomebrewPhpRequirement < Requirement
  fatal true

  satisfy { self.class.homebrew_php_is_tapped? }

  def message; <<-EOS.undent
    "homebrew-php must be tapped `brew tap homebrew/homebrew-php`."
    EOS
  end

  def self.homebrew_php_is_tapped?
    File.exist?("#{HOMEBREW_REPOSITORY}/Library/Taps/homebrew/homebrew-php/Requirements/composer-requirement.rb") &&
      File.exist?("#{HOMEBREW_REPOSITORY}/Library/Taps/homebrew/homebrew-php/Abstract/abstract-php-phar.rb")
  end
end

class VirtualboxRequirement < Requirement
  fatal false

  satisfy { which("VBoxManage") }

  def message; <<-EOS.undent
    "virtuabox is required to run VM's. Consider running `brew install Caskroom/cask/virtualbox`."
    EOS
  end
end

class VagrantRequirement < Requirement
  fatal false

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
  url "https://github.com/acquia/club/releases/download/0.3/club.phar"
  sha256 "01d0ceba5ae5960566ba930dcbede23a0cb845c3931c8167da904e92423aa207"

  depends_on ComposerRequirement
  depends_on HomebrewPhpRequirement
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
