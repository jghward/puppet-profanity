class profanity::prerequisites {

  $prerequisites          = $profanity::prerequisites
  $libstrophe_tmp_dir     = $profanity::libstrophe_tmp_dir
  $libstrophe_install_dir = $profanity::libstrophe_install_dir
  $libstrophe_url         = $profanity::libstrophe_url
  $libstrophe_version     = $profanity::libstrophe_version

  Exec {
    cwd => $libstrophe_tmp_dir,
  }

  package { $prerequisites:
    ensure => installed,
  } ->

  profanity::gitrepo { $libstrophe_tmp_dir:
    ensure   => present,
    source   => $libstrophe_url,
    revision => $libstrophe_version,
  }

  exec { "bootstrap.sh in ${libstrophe_tmp_dir}":
    command   => "${libstrophe_tmp_dir}/bootstrap.sh",
    subscribe => [Package[$prerequisites], Profanity::Gitrepo[$libstrophe_tmp_dir]],
  } ~>

  exec { "configure in ${libstrophe_tmp_dir}":
    command => "${libstrophe_tmp_dir}/configure --prefix=${libstrophe_install_dir}",
  } ~>

  exec { "make in ${libstrophe_tmp_dir}":
    command => 'make',
  } ~>

  exec { "make install in ${libstrophe_tmp_dir}":
    command     => 'make install',
  }

  if $::operatingsystem in ['CentOS'] {
    exec { '/sbin/ldconfig':
      subscribe => Exec["make install in ${libstrophe_tmp_dir}"],
    }
  }

}
