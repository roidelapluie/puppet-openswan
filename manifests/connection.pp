define openswan::connection (
  $left,
  $right,
  $esp,
  $foreignip,
  $ike,
  $rightsubnet = undef,
  $rightsubnets = undef,
  $leftsubnet = undef,
  $leftsubnets = undef,
  $salifetime = '8h',
  $ikelifetime = '1h'
) {
  if (!$leftsubnet) and (!$leftsubnets) {
    fail( '$leftsubnets and $leftsubnet cannot be both empty' )
  }
  if (!$rightsubnet) and (!$rightsubnets) {
    fail( '$rightsubnets and $rightsubnet cannot be both empty' )
  }
    file {
      "/etc/ipsec.d/${name}.conf":
        ensure  => present,
        content => template('openswan/connection.erb'),
        notify  => Service['ipsec'],
        require => Package['openswan'],
    }
    exec {
      "/usr/sbin/ipsec auto --asynchronous --up ${name}":
        unless  => "ip xfrm state|grep \"src ${left} dst ${right}\"",
        path    => '/sbin:/bin',
        require => Service['ipsec'],
    }

}
