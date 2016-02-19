class profanity::params {

  # Install through package manager if available
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
    'CentOS': {
      $prerequisites = [
        'epel-release', 'git', 'automake', 'gcc', 'autoconf',
        'cmake', 'openssl-devel', 'expat-devel', 'ncurses-devel',
        'glib2-devel', 'libnotify-devel', 'libcurl-devel',
        'libXScrnSaver-devel', 'libotr-devel', 'readline-devel',
        'libtool', 'gpgme-devel', 'libuuid-devel'
      ]
    }
    default:              {}
  }
  $version                = '0.4.7'
  $url                    = 'https://github.com/boothj5/profanity.git'
  $tmp_dir                = '/var/tmp/profanity'
  $libstrophe_version     = '0.8.8'
  $libstrophe_url         = 'https://github.com/strophe/libstrophe.git'
  $libstrophe_install_dir = '/usr'
  $libstrophe_tmp_dir     = '/var/tmp/libstrophe'

  # Configuration details
  $user = 'root'
  case $user {
    'root': {
      $config_home      = '/root/.config'
      $data_home_parent = '/root/.local'
    }
    default: {
      $config_home      = "/home/${user}/.config"
      $data_home_parent = "/home/${user}/.local"
    }
  }
  $data_home = "${data_home_parent}/share"

  # profrc file
  $manage_profrc   = true
  $profrc_settings = {
    #'ui'            => {
      #splash           => 'true',
      #intype           => 'true',
      #beep             => 'false',
      #statuses_muc     => 'all',
      #theme            => 'boothj5',
      #history          => 'true',
      #titlebar         => 'true',
      #mouse            => 'false',
      #flash            => 'false',
      #vercheck         => 'false',
      #statuses_console => 'all',
      #statuses_chat    => 'all',
    #},
    #'connection'    => {
      #autoping  => '60',
      #reconnect => '5',
      #account   => 'me@server.org',
    #},
    #'chatstates'    => {
      #enabled => 'true',
      #outtype => 'false',
      #gone    => '10',
    #},
    #'notifications' => {
      #remind          => '60',
      #invite          => 'true',
      #sub             => 'true',
      #message         => 'true',
      #room            => 'mention',
      #message_current => 'true',
      #room_current    => 'true',
      #typing          => 'true',
      #typing_current  => 'true',
      #message_text    => 'true',
      #room_text       => 'true',
    #},
    #'alias'         => {
      #friends => '/who online friends',
      #bob     => '/msg bob@server.org hey wassup?',
    #},
    #'otr'           => {
      #warn   => 'true',
      #log    => 'redact',
      #policy => 'manual',
    #},
    #'presence'      => {
      #autoaway_mode    => 'away',
      #autoaway_time    => '15',
      #autoaway_message => 'Away from computer',
      #autoaway_check   => 'true',
    #},
  }

  # Account configuration details
  $manage_accounts = true
  $accounts        = {
    #'me' => {
      #'jid'    => 'me@chatty',
      #'server' => 'talk.chat.com',
      #'port'   => '5111',
      #'muc'    => 'chatservice.mycompany.com',
      #'nick'   => 'dennis',
      #'status' => 'dnd',
      #'dnd'    => '-1',
    #},
  }

}
