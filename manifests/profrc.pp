class profanity::profrc {

  $config_home     = $profanity::config_home
  $profrc_file     = "${config_home}/profanity/profrc"
  $profrc_settings = $profanity::profrc_settings
    
  file { $profrc_file:
    ensure  => present,
    content => template("${module_name}/profrc.erb"),
    mode    => '0600',
  }

}
