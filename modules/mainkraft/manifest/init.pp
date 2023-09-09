class mainkraft {
  
  file { '/opt/minekraft':
    ensure => directory,
    before => File['minekraft'],
  }
  
  file { 'minekraft':
    path=> '/opt/minekraft/minekraft',
    source => 'https://piston-data.mojang.com/v1/objects/84194a2f286ef7c14ed7ce0090dba59902951553/server.jar',
    mode => '755',
    require => File['/opt/minekraft'],
  }
    
  file { 'minekraft_service':
    path=> '/etc/systemd/system/minekraft/minekraft.service',
    source => 'puppet:///modules/minekraft/minekraft.service',
    notify => Service ['minekraft']
  }
  
  service { 'minekraft':
    ensure => running,
  }
}
