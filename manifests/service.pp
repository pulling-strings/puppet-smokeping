class smokeping::service {

  $ensure = $smokeping::start ? { true => running, false => stopped, default => undef }

  if($virtual!='docker'){
    service { 'smokeping':
      ensure   => $ensure,
      enable   => $smokeping::enable,
    }
  }

}
