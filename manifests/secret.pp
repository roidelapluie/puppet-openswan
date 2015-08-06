define openswan::secret (
  $remote_ip,
  $secret,
  $local_ip = '%any',
) {
  file {
    "/etc/ipsec.d/${name}.secrets":
      ensure  => present,
      content => "${local_ip} ${remote_ip}: PSK \"${secret}\"\n",
      require => Package['openswan'],
  }
}
