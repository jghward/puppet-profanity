# Class: profanity::configure
# ===========================
#
# This class creates the data and configuration file directories.
#
# Authors
# -------
#
# Jon Ward <jghward+puppet@gmail.com>
#
# Copyright
# ---------
#
# Copyright 2016 Jon Ward.
#
class profanity::configure {

  $user             = $profanity::user
  $config_home      = $profanity::config_home
  $data_home_parent = $profanity::data_home_parent
  $data_home        = $profanity::data_home

  File {
    owner => $user,
    group => $user,
  }

  file { [$config_home, $data_home_parent, $data_home]:
    ensure => directory,
    mode   => '0700',
  }

  file { "${config_home}/profanity":
    ensure => directory,
    mode   => '0700',
  }

  file { "${data_home}/profanity":
    ensure => directory,
    mode   => '0700',
  }

}
