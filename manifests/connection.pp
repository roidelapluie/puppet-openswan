define openswan::connection (
  $left,
  $leftsubnet,
  $right,
  $rightsubnet,
  $esp,
  $foreignip,
  $ike
) {
    file {
      "/etc/ipsec.d/${name}.conf":
        ensure  => present,
        content => template('openswan/connection.erb'),
        notify  => Service['ipsec'],
        require => Package['openswan'],
    }
    exec {
      "/usr/sbin/ipsec auto --up ${name}":
        unless  => "/bin/ping -c 4 -w 6 ${foreignip}",
        require => Service['ipsec'],
    }

}
