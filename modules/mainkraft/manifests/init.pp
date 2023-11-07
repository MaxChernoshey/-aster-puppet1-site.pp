class mainkraft {

  file { '/opt/mainkraft':
    ensure => directory,
  }
  
  file { '/opt/mainkraft/eula.txt': 
    ensure => file,
    content => 'eula=TRUE',
  }
  
  file { 'mainkraft':
    path => '/opt/mainkraft/server.jar',
    source => 'https://piston-data.mojang.com/v1/objects/84194a2f286ef7c14ed7ce0090dba59902951553/server.jar',
    mode => '755',
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
