# Class: profanity::params
# ===========================
#
# Inherited by the main profanity class, this class sets default values for
# all params defined there.
#
# Variables
# ----------
#
# * `install_from_package`
#  If true, profanity::package will be calledby the main class. Otherwise,
#  profanity::prerequisites followed by profanity::install are called.
#
# * `libotr_package`
#  The libotr package to install as a prerequisite. Differs depending on OS
#  version.
#
# * `prerequisites`
#  The packages installed by profanity::prerequisites. Differs depending on OS
#  version.
#
# * `version`
#  The version of Profanity to install. This is the tag that is checked out
#  from the Git repository if installing from source.
#
# * `url`
#  The location of the remote Profanity source.
#
# * `tmp_dir`
#  The location of the Profanity source on the system from where it
#  will be built.
#
# * `libstrophe_version`
#  The version of the XMPP library required by Profanity.
#
# * `libstrophe_url`
#  The location of the remote XMPP library source.
#
# * `libstrophe_tmp_dir`
#  The location of the XMPP library source on the system from where it will be
#  built.
#
# * `user`
#  The system user to manage Profanity for.
#
# * `config_home`
#  The parent directory to use for Profanity configuration files including
#  profrc.
#
# * `data_home_parent`
#  The parent directory to use for Profanity data including accounts
#  information.
#
# * `data_home`
#  The directory to use for Profanity data.
#
# * `manage_profrc`
#  If true, the module will manage the profrc file. Any manually added data to
#  profrc will be purged.
#
# * `profrc_settings`
#  A hash of values used to populate the profrc file.
#
# * `manage_accounts`
#  If true, use profanity::account to populate the accounts file.
#
# * `accounts`
#  A hash of accounts used the populate the accounts file.
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
  $manage_profrc   = false
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
  $manage_accounts = false
  $accounts        = {
    #'me' => {
      #'enabled'         => 'true',
      #'jid'             => 'me@chatty',
      #'server'          => 'talk.chat.com',
      #'port'            => '5111',
      #'muc'             => 'chatservice.mycompany.com',
      #'nick'            => 'dennis',
      #'status'          => 'dnd',
      #'priority_online' => 0,
      #'priority_chat'   => 0,
      #'priority_away'   => 0,
      #'priority_xa'     => 0,
      #'priority_dnd'    => -1,
    #},
  }

}
