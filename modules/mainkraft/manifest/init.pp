class mainkraft {
  class { 'java' :
    package => 'java-1.8.0-openjdk-devel',
  }

  file { '/opt/minekraft':
    ensure => directory,
  }
  
  
  
  
  
  
  
  file { '/etc/systemd/system/minekraft.service':
    ensure => file,
    source => 'puppet:///modules/minekraft/minekraft.service',
  }
  exec { 'clone wcg':
    command => '/usr/bin/git clone
    https://github.com/Fenikks/word-cloud-generator.git.',
    cwd => "/opt/wordcloud",
    returns => [0, 128],
    require => File['/opt/wordcloud'],
  }
  exec { 'make wcg':
    cwd => "/opt/wordcloud",
    command => 'make',
    path => "/usr/bin:/usr/local/go/bin",
    logoutput => true,
    require => Exec['clone wcg'],
    environment => ['GOPATH=/usr/local/go/bin',
    'GOCACHE=/tmp/gocache'],
  }
  service { 'wordcloud':
    ensure => running,
  }
  exec { 'Open wcg port 8888':
    command => "/usr/bin/firewall-cmd --addport=8888/tcp",
  }
}
