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
      cwd     => "${target_dir}/${name}",
      command => "git checkout ${revision}",
      unless  => "git tag 2> /dev/null | grep '^${revision}$'",
    }
  }
  elsif $ensure == 'absent' {
    file { "${target}/${name}":
      ensure => absent,
    } 
  }

}
