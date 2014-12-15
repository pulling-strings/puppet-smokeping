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
      mode  => 'u+x',
      source => 'puppet:///modules/smokeping/smokeping_run',
      owner  => root,
      group  => root,
    }

    file{'/etc/service/smokeping-cgi':
      ensure => directory,
    } ->

    file { '/etc/service/smokeping-cgi/run':
      ensure => file,
      mode  => 'u+x',
      source => 'puppet:///modules/smokeping/fastcgi_run',
      owner  => root,
      group  => root,
    }
  }
}
