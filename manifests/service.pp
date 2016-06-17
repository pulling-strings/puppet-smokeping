# smokeping service setup
class smokeping::service {

  $ensure = $smokeping::start ? {
    true => running, false => stopped, default => undef
  }

  if $::virtual != 'docker' {
    service { 'smokeping':
      ensure => $ensure,
      enable => $smokeping::enable,
    }

    service { 'apache2':
      ensure => stopped,
      enable => false
    } ~>

    service { 'lighttpd':
      ensure => running,
      enable => true
    }


  }

}
