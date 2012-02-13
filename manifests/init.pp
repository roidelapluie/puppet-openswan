class openswan {
  package {
    'openswan':
      ensure => installed,
  }

  service {
    'ipsec':
      ensure     => running,
      hasstatus  => true,
      hasrestart => true,
  }
  file {
    '/etc/ipsec.conf':
      ensure  => present,
      mode    => '0600',
      owner   => 'root',
      notify  => Service['ipsec'],
      require => Package['ipsec'],
      content => template('openswan/openswan.conf.erb'),
  }
}
