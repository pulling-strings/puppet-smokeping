# default smokeping settings to start with
class smokeping::defaults {

  $probes = [
    {name => 'FPing', binary  => '/usr/bin/fping'},
    {name => 'DNS', binary => '/usr/bin/dig'},
  ]

  package{'sendmail':
    ensure  => present
  }

  class {'smokeping':
    mode   => 'standalone',
    probes => $probes,
  }

  smokeping::target { 'World':
    menu      => 'World',
    pagetitle => 'Connection to the World',
    alerts    => []
  }

  smokeping::target { 'Google':
    hierarchy_parent => 'World',
    hierarchy_level  => 2,
    menu             => 'google.com',
    pagetitle        => 'Google',
    alerts           => []
  }

  smokeping::target { 'Google-fping':
    hierarchy_parent => 'Google',
    hierarchy_level  => 3,
    menu             => 'google.com ping',
    host             => 'google.com',
    alerts           => []
  }

  smokeping::target { 'Google-DNS':
    hierarchy_parent => 'Google',
    hierarchy_level  => 3,
    probe            => 'DNS',
    menu             => 'google.com dns',
    host             => '8.8.8.8',
    alerts           => []
  }
}
