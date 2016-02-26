# Class: profanity::package
# ===========================
#
# If the module is being used on a system where Profanity is available via
# a package management system, $profanity::install_from_package can be set
# to true and this class will be called. Installs Profanity using the
# 'package' resource type.
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

  package { 'profanity':
    ensure => installed,
  }

}
