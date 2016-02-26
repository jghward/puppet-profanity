# puppet-profanity
A Puppet module to install and configure the Profanity chat client http://www.profanity.im

##Compatibility
Requires Puppet 4.0.0 or higher

##Supported OS:

Debian Wheezy+

Ubuntu Precise+

CentOS 7+

##Dependencies:
puppetlabs/concat

```
puppet module install puppetlabs/concat
```

##Usage:

```
include profanity
```

Optionally override the default parameters (in params.pp) by using the 'class' syntax, e.g.

```
class { 'profanity':
  version              => '0.4.7',
  install_from_package => false,
  manage_accounts      => true,
  manage_profrc        => true,
}
```

If $manage_accounts is true, a hash of accounts can be passed in using the $accounts param:

```
$accounts = {
  'me' => {
    'jid'    => 'me@chatty',
    'server' => 'talk.chat.com',
    'port'   => '5111',
    'muc'    => 'chatservice.mycompany.com',
    'nick'   => 'dennis',
    'status' => 'dnd',
    'dnd'    => '-1',
  },
}

class { 'profanity':
  accounts => $accounts,
}
```

You can also use the 'profanity::account' defined type directly in your Puppet code:

```
profanity::account { 'me_work':
  jid      => 'me@mycompany',
  presence => 'Profanity-work',
  nick     => 'Employee #4354',
}
```
All parameters are optional.

The profrc file can also be managed by setting $manage_profrc to true and uncommenting the required settings in params.pp.

##TODO:

Support more operating systems

