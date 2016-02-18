# puppet-profanity
A Puppet module to install and configure the Profanity chat client

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
  version              => '0.4.3',
  install_from_package => true,
  manage_accounts      => false,
}
```

If 'manage_accounts' is true (the default), a hash of accounts can be passed in using the 'accounts' param:

```
$accounts = {
  'dave' => {
    'jid'  => 'dave@foobar.baz',
    'nick' => 'Dave',
  },
  'hipchat' => {
    'jid' => '123456-7890@chat.hipchat.com',
    'muc' => 'conf.hipchat.com',
  }
}

class { 'profanity':
  accounts => $accounts,
}
```

You can also use the 'profanity::account' defined type directly in your Puppet code:

```
profanity::account { 'dave_work':
  jid      => 'dave@mycompany.com',
  presence => 'Profanity-work',
  nick     => 'Employee #4354',
}
```

##TODO:
Manage the profanityrc file

Support more operating systems

