define openswan::connection (
  $left,
  $leftsubnet,
  $right,
  $rightsubnet,
  $esp,
  $ike
) {
    file {
      "/etc/ipsec.d/${name}.conf":
        ensure  => present,
        content => template('openswan/connection.erb'),
    }
}
