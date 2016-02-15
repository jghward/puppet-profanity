class profanity::params {

  # Install through package manager if available (uses Homebrew on Mac)
  $install_from_package = false

  # Manual install
  case $::operatingsystem {
    'Ubuntu', 'Debian': {
      $libotr_package = $::lsbdistcodename ? {
        /^(wheezy|precise)$/     => 'libotr2-dev',
        default                  => 'libotr5-dev',
      }
      $prerequisites = [
        'git', 'automake', 'autoconf', 'libssl-dev', 'libexpat1-dev',
        'libncursesw5-dev', 'libglib2.0-dev', 'libnotify-dev',
        'libcurl4-openssl-dev', 'libxss-dev', $libotr_package,
        'libreadline-dev', 'libtool', 'libgpgme11-dev', 'uuid-dev'
      ]
    }
    default:              {}
  }
  $version = '0.4.7'
  $url = 'https://github.com/boothj5/profanity.git'
  $tmp_dir = '/var/tmp/profanity'
  $libstrophe_version = '0.8.8'
  $libstrophe_url = 'https://github.com/strophe/libstrophe.git'
  $libstrophe_install_dir = '/usr'
  $libstrophe_tmp_dir = '/var/tmp/libstrophe'

  # Configuration details
  $user = 'root'
  case $user {
    'root': {
      $config_home = '/root/.config'
      $data_home_parent = '/root/.local'
    }
    default: {
      $config_home = "/home/${user}/.config"
      $data_home_parent = "/home/${user}/.local"
    }
  }
  $data_home = "${data_home_parent}/share"

  # Account configuration details
  $manage_accounts = true
  $accounts = { }

}
