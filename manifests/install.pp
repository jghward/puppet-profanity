# Class: profanity::package
# ===========================
#
# This class will install Profanity from source if not already installed.
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
class profanity::install {

  $url     = $profanity::url
  $version = $profanity::version
  $tmp_dir = $profanity::tmp_dir

  $filename         = "profanity-${version}.tar.gz"
  $full_url         = "${url}/${filename}"
  $working_dir      = "${tmp_dir}/profanity-${version}"

  Exec {
    cwd => $working_dir,
  }

  staging::file { $filename:
    source => $full_url,
  }

  staging::extract { $filename:
    target  => $tmp_dir,
    creates => $working_dir,
    require => Staging::File[$filename],
  }

  exec { "bootstrap.sh in ${working_dir}":
    command => "${working_dir}/bootstrap.sh",
    require => Staging::Extract[$filename],
  } ~>

  exec { "configure in ${working_dir}}":
    command => "${working_dir}/configure",
  } ~>

  exec { "make in ${working_dir}":
    command => 'make',
  } ~>

  exec { "make install in ${working_dir}":
    command => 'make install',
  }

}
