# Define: profanity::gitrepo
# ===========================
#
# Ensures that a git repository is prenset or absent on the system.
#
# Parameters
# ----------
#
# * `ensure`
#  Can be set to 'present' or 'absent'. If set to present and the repository
#  is not present on the system, attempt to clone it from the specified
#  source.
# 
# * `source`
#  The remote location of the git repository.
#
# * `revision`
#  The name of the tag, branch or commit that should be checked out in the
#  repository's working directory.
#
# Variables
# ----------
#
# * `target`
#  The target location on the system for the repository. Passed in as the $name
#  var.
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
define profanity::gitrepo(
  String $ensure,
  String $source,
  String $revision,
) {

  $target = $name

  if $ensure == 'present' {
    Exec {
      path        => '/usr/bin:/bin:/usr/share/bin:/sbin:/usr/sbin',
      refreshonly => false,
    }

    file { $target:
      ensure => directory,
    }

    exec { "clone to ${target}":
      command => "git clone ${source} ${target} -b ${revision}",
      creates => "${target}/.git/config",
    } ->

    exec { "checkout ${target} ${revision}":
      cwd     => $target,
      command => "git checkout ${revision}",
      unless  => "git tag 2> /dev/null | grep '^${revision}$'",
    }
  }
  elsif $ensure == 'absent' {
    file { $target:
      ensure => absent,
    }
  }

}
