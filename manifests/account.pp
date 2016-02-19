define profanity::account(
  String  $user            = 'root',
  String  $ensure          = 'present',
  Boolean $default_account = false,
  String  $enabled         = 'true',
  String  $status          = 'online',
  String  $resource        = 'profanity',
  Any     $jid             = undef,
  Any     $server          = undef,
  Any     $port            = undef,
  Any     $password        = undef,
  Any     $eval_password   = undef,
  Any     $muc             = undef,
  Any     $nick            = undef,
  Any     $otr             = undef,
  Any     $pgpkeyid        = undef,
  Integer $priority_online = 0,
  Integer $priority_chat   = 0,
  Integer $priority_away   = 0,
  Integer $priority_xa     = 0,
  Integer $priority_dnd    = 0,
) {

  include profanity::configure
  
  $data_home = $profanity::data_home

  concat::fragment { "account_${name}":
    target  => "${data_home}/profanity/accounts",
    content => template("${module_name}/accounts.erb"),
    order   => '10',
  }

}
