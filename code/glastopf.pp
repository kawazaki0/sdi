Vcsrepo['/opt/BFR'] -> Exec['install_bfr']
Service['apache2'] -> Package['glastopf']

vcsrepo { '/opt/BFR':
  ensure   => present,
  provider => git,
  source   => 'git://github.com/glastopf/BFR.git',
}

exec { 'install_bfr':
  command => 'make && make install; echo "zend=bfr.so" >> /etc/php5/cli/php.ini',
  cwd     => '/opt/BFR',
  unless  => 'grep -q "zend=bfr.so" /etc/php5/cli/php.ini',
}

service { 'apache2':
  ensure => stopped,
  enable => false,
}

package { 'glastopf':
  ensure   => present,
  name     => 'glastopf',
  provider => 'pip',
}
