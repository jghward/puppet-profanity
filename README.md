# profanity

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with profanity](#setup)
    * [What profanity affects](#what-profanity-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with profanity](#beginning-with-profanity)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This module allows you to manage Profanity, a console-based XMPP chat client. It has been tested on Ubuntu, Debian and CentOS. Puppet 4.0.0 or higher is required.

As well as Profanity itself, the module can also manage Profanity accounts and the .profrc file. It also provides the profanity::account defined type, allowing accounts to be managed from other modules.

Profanity website: http://profanity.im

## Setup

### What profanity affects

Profanity will install libstrophe, as well as several packages. Details can be found inside params.pp.

The module is dependant on puppetlabs/concat.

### Setup Requirements

### Beginning with profanity

As a bare minimum, the following will ensure Profanity is installed on your system:

```
include profanity
```

## Usage

By default the module will not manage the .profrc file or any chat accounts. You are therefore free to create or alter these manually without Puppet interfering.

Optionally override the default parameters (in params.pp) by using the 'class' syntax, e.g.

```
class { 'profanity':
  install_from_package => true,
  version              => '0.4.7-1',
  manage_accounts      => true,
  manage_profrc        => true,
}
```

If $manage_accounts is true, a hash of accounts can be passed in using the 'accounts' attribute:

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

## Reference

An individual reference is contained within each class.

## Limitations

The module has currently only been tested on the following OS:

Ubuntu 14.04 and higher
Debian 7 and higher
CentOS 7 and higher

Puppet 4.0 or higher required.

## Development

Pull requests welcome. Adding Mac and Cygwin support is a high priority, as well as adding support for other Linux distributions.

