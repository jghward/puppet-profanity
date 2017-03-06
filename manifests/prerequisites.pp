# Class: profanity::prerequisites
# ===========================
#
# This class installs the prerequisite packages in $profanity::prerequisites
# and the XMPP library from source.
#
# Authors
# -------
#
# Jon Ward <jghward+puppet@gmail.com>
#
# Copyright
# ---------
#
# Copyright 2017 Jon Ward.
#
class profanity::prerequisites {

  $prerequisites         = $profanity::prerequisites
  $libmesode_tmp_dir     = $profanity::libmesode_tmp_dir
  $libmesode_install_dir = $profanity::libmesode_install_dir
  $libmesode_url         = $profanity::libmesode_url
  $libmesode_version     = $profanity::libmesode_version

  $libmesode_filename    = "${libmesode_version}.zip"
  $libmesode_full_url    = "${libmesode_url}/${libmesode_filename}"
  $libmesode_working_dir = "${libmesode_tmp_dir}/libmesode-${libmesode_version}"

  Exec {
    cwd => $libmesode_working_dir,
  }

  package { $prerequisites:
    ensure => installed,
  } ->

  archive { "${libmesode_tmp_dir}/${libmesode_filename}":
    source       => $libmesode_full_url,
    extract_path => $libmesode_tmp_dir,
    creates      => $libmesode_working_dir,
    cleanup      => true,
  }

  exec { "bootstrap.sh in ${libmesode_working_dir}":
    command   => "${libmesode_working_dir}/bootstrap.sh",
    subscribe => [Package[$prerequisites], Archive["${libmesode_tmp_dir}/${libmesode_filename}"]],
  } ~>

  exec { "configure in ${libmesode_working_dir}":
    command => "${libmesode_working_dir}/configure --prefix=${libmesode_install_dir}",
  } ~>

  exec { "make in ${libmesode_working_dir}":
    command => 'make',
  } ~>

  exec { "make install in ${libmesode_working_dir}":
    command     => 'make install',
  }

  if $::operatingsystem in ['CentOS'] {
    exec { '/sbin/ldconfig':
      subscribe => Exec["make install in ${libmesode_working_dir}"],
    }
  }

}
