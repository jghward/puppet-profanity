# Class: profanity::package
# ===========================
#
# If the module is being used on a system where Profanity is available via
# a package management system, $profanity::install_from_package can be set
# to true and this class will be called. Installs Profanity using the
# 'package' resource type.
#
# Variables
# ----------
#
# * `package_name`
#  The name of the package in the package manager.
#
# * `package_ensure`
#  Passed to the 'ensure' attribute of the package resource.
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
class profanity::package {

  $package_name   = $profanity::package_name
  $package_ensure = $profanity::package_ensure

  package { $package_name:
    ensure => $package_ensure,
  }

}
