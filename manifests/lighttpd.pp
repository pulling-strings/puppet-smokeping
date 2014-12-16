# Setting up lighttpd for docker
class smokeping::lighttpd {

  package{'lighttpd':
    ensure  => present
  } ->

  file { '/etc/lighttpd/conf-available/10-cgi.conf':
    ensure => file,
    mode   => '0644',
    source => 'puppet:///modules/smokeping/10-cgi.conf',
    owner  => root,
    group  => root,
  } ->

  exec{'enable lighttpd cgi module':
    command => 'lighttpd-enable-mod cgi',
    user    => 'root',
    path    => '/usr/sbin/'
  } ->

  exec{'enable lighttpd fastcgi module':
    command => 'lighttpd-enable-mod fastcgi',
    user    => 'root',
    path    => '/usr/sbin/'
  } ->

  file{'/var/www/smokeping':
    ensure  => link,
    target  => '/usr/share/smokeping/www/',
    require => Package['smokeping']
  } ->

  file{'/var/www/smokeping/smokeping.cgi':
    ensure => link,
    target => '/usr/lib/cgi-bin/smokeping.cgi'
  } ->

  file{'/var/www/cgi-bin':
    ensure => link,
    target => '/usr/lib/cgi-bin'
  } ->

  exec{'chmod stderr stdout':
    command => 'chmod 0777 /dev/stderr /dev/stdout',
    user    => 'root',
    path    => '/bin',
  }

}
