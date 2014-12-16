# Setting up lighttpd for docker
class smokeping::lighttpd {
  $enable_cgi = 'lighttpd-enable-mod cgi'
  $enable_fastcgi = 'lighttpd-enable-mod fastcgi'

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

  exec{'enabling lighttpd modules':
    command => "${enable_cgi} && ${enable_fastcgi}",
    user    => 'root',
    path    => ['/usr/bin','/bin',]
  } ->

  file{'/var/www/smokeping':
    ensure  => link,
    target  => '/usr/share/smokeping/www',
    require => Package['smokeping']
  } ->

  file{'/var/www/':
    ensure => link,
    target => '/usr/lib/cgi-bin'
  } ->

  file{'/var/www/smokeping':
    ensure => link,
    target => '/usr/lib/cgi-bin/smokeping.cgi'
  } ->

  exec{'chmod stderr stdout':
    command => 'chmod 0777 /dev/stderr /dev/stdout',
    user    => 'root',
    path    => ['/usr/bin','/bin',]
  }
  


}
