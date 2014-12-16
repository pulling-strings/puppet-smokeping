# Setting up smokeping
class smokeping::runit {
  if($::virtual == 'docker'){
    package{'spawn-fcgi':
      ensure  => present
    }
    file{'/etc/service/smokeping':
      ensure => directory,
    } ->

    file { '/etc/service/smokeping/run':
      ensure => file,
      mode   => 'u+x',
      source => 'puppet:///modules/smokeping/smokeping_run',
      owner  => root,
      group  => root,
    }

    file{'/etc/service/lighttpd':
      ensure => directory,
    } ->

    file { '/etc/service/lighttpd/run':
      ensure => file,
      mode   => 'u+x',
      source => 'puppet:///modules/smokeping/lighttpd_run',
      owner  => root,
      group  => root,
    }
  }
}
