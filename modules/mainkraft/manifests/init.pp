class mainkraft {
  
  file { '/opt/mainkraft':
    ensure => directory,
    before => File['mainkraft'],
  }
  
  file { 'mainkraft':
    path => '/opt/mainkraft/mainkraft',
    source => 'https://piston-data.mojang.com/v1/objects/84194a2f286ef7c14ed7ce0090dba59902951553/server.jar',
    mode => '755',
    require => File['/opt/mainkraft'],
  }
    
  file { 'mainkraft_service':
    path => '/etc/systemd/system/mainkraft.service',
    source => 'puppet:///modules/mainkraft/mainkraft.service',
    notify => Service['mainkraft'],
  }
  
  service { 'mainkraft':
    ensure => running,
  }
}
