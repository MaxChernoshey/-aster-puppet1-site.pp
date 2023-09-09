node slave1.puppet {
  package { 'httpd':
    ensure => installed, 
  }
  
  service { 'httpd': # описываем сервис 'httpd'
    ensure => running, # он должен быть запущен
    enable => true, # его нужно запускать автоматически при старте системы
  }
  
  service { 'firewalld':
    ensure => stopped,
    enable => false,
  }
  
  file { '/var/www/html/index.html': 
    path => '/var/www/html/index.html',
    source => 'https://raw.githubusercontent.com/MaxChernoshey/itacademy-devops-files/master/02-tools/index.html',
  }
}

node slave2.puppet {
  package { 'php':
    ensure => installed,
  }
  package { 'httpd':
    ensure => installed,
  }
  service { 'httpd': # описываем сервис 'httpd'
    ensure => running, # он должен быть запущен
    enable => true, # его нужно запускать автоматически при старте системы
  }
  service { 'firewalld':
    ensure => stopped,
    enable => false,
  }
  file { '/var/www/html/index.html':
    ensure  => absent,
  }
  
  file { '/var/www/html/index.php': 
   path => '/var/www/html/index.php',
   source => 'https://raw.githubusercontent.com/MaxChernoshey/itacademy-devops-files/master/02-tools/index.php',
  }
}

node master.puppet {
  class {'nginx':
  } 

  service {'firewalld':
    ensure => stopped,
    enable => false,
  }

  class {'selinux':
    mode => 'disabled',
  }
  
  nginx::resource::server { '192.168.50.5:81':
  listen_port => 81,
  proxy       => 'http://192.168.50.10/',
  }
  nginx::resource::server { '192.168.50.5:82':
  listen_port => 82,
  proxy       => 'http://192.168.50.15/',
 }
 }
 node mineserver.puppet {
   
   firewalld_port { 'Open port 8888 in the public zone':
    ensure   => present,
    zone     => 'public',
    port     => 8888,
    protocol => 'tcp',
   }
   
   include mainkraft

}

