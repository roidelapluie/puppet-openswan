class openswan {
  package {
    'openswan':
      ensure => installed,
  }

  file {
    '/etc/ipsec.conf':
      ensure  => present,
      mode    => '0600',
      owner   => 'root',
      content => template('openswan/openswan.conf.erb'),
  }
}
