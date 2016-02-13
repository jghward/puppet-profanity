# puppet-profanity
A Puppet module to install and configure the Profanity chat client

##Compatibility
Requires Puppet 4.0.0 or higher
Ubuntu is currently the only supported OS

##Dependencies:
puppetlabs/concat

puppetlabs/vcsrepo

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
  'jon' => {
    'jid'  => 'jon@foobar.baz',
    'nick' => 'Jon',
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
profanity::account { 'jon_work':
  jid  => 'jon@mycompany.com',
  nick => 'Employee #4354',
}
```

##Known issues:
If a branch name of the Profanity repo includes the the name of the $version you specify, the following error occurs:

```
Error: Execution of '/usr/bin/git checkout --force -b 0.4.7 --track origin/0.4.7' returned 128: fatal: Cannot update paths and switch to branch '0.4.7' at the same time.
```

This is due to a bugfix in puppetlabs/vcsrepo that has not yet made it to the version on the Forge (1.3.2 at the time of writing.)

(https://github.com/puppetlabs/puppetlabs-vcsrepo/commit/7fe9cb225b6458e468469597a54753f1ea621e00)

Until then, either apply this change yourself, or get vcsrepo directly from GitHub.

##TODO:
Manage the profanityrc file

Support more operating systems

