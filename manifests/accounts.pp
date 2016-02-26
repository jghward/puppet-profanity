# Class: profanity::accounts
# ===========================
#
# Called if $profanity::manage_accounts is set to true. Uses concat to create
# the accounts file, and the profanity::account defined type to create concat
# fragments to populate it.
#
# Variables
# ----------
#
# * `data_home`
#  Helps determine the location of the accounts file.
#
# * `accounts`
#  A hash of accounts that is passed to the create_resources function to create
#  content inside the accounts file.
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
class profanity::accounts {

  $data_home = $profanity::data_home
  $accounts  = $profanity::accounts

  concat { "${data_home}/profanity/accounts":
    ensure  => present,
    mode    => '0600',
    require => Class['profanity::configure'],
  }

  create_resources(profanity::account, $accounts)

}
