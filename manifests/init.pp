class profanity(
  Boolean $install_from_package   = $profanity::params::install_from_package,
  Array   $prerequisites          = $profanity::params::prerequisites,
  String  $version                = $profanity::params::version,
  String  $url                    = $profanity::params::url,
  String  $tmp_dir                = $profanity::params::tmp_dir,
  String  $libstrophe_url         = $profanity::params::libstrophe_url,
  String  $libstrophe_version     = $profanity::params::libstrophe_version,
  String  $libstrophe_install_dir = $profanity::params::libstrophe_install_dir,
  String  $libstrophe_tmp_dir     = $profanity::params::libstrophe_tmp_dir,
  String  $user                   = $profanity::params::user,
  Boolean $manage_accounts        = $profanity::params::manage_accounts,
  Hash    $accounts               = $profanity::params::accounts,
  Boolean $manage_profrc          = $profanity::params::manage_profrc,
  Hash    $profrc_settings        = $profanity::params::profrc_settings,
) inherits profanity::params {

  $supported = ['Ubuntu', 'Debian', 'CentOS']

  if ! ($operatingsystem in $supported) {
    notice("Unsupported OS. Please install manually.")
    $install = false
  }
  else {
    $install = true
  }

  if $install {
    Exec {
      user        => 'root',
      path        => '/usr/bin:/bin',
      refreshonly => true,
    }

    if $install_from_package {
      include profanity::package
    }
    else {
      class { 'profanity::prerequisites': } ~>
      class { 'profanity::install': }
    }

    include profanity::configure

    if $manage_accounts {
      include profanity::accounts
    }

    if $manage_profrc {
      include profanity::profrc
    }
  }
}
