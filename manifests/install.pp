class profanity::install {

  $url     = $profanity::url
  $version = $profanity::version
  $tmp_dir = $profanity::tmp_dir

  Exec {
    cwd => $tmp_dir,
  }

#  vcsrepo { $tmp_dir:
#    ensure     => present,
#    provider   => git,
#    source     => $url,
#    revision   => $version,
#    submodules => false,
#  } ~>

  profanity::gitrepo { $tmp_dir:
    ensure     => present,
    source     => $url,
    revision   => $version,
  } ~>

  exec { "bootstrap.sh in ${tmp_dir}":
    command => "${tmp_dir}/bootstrap.sh",
  } ~>

  exec { "configure in ${tmp_dir}":
    command => "${tmp_dir}/configure",
  } ~>

  exec { "make in ${tmp_dir}":
    command => 'make',
  } ~>

  exec { "make install in ${tmp_dir}":
    command => 'make install',
  }

}
