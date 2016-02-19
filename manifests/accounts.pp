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
