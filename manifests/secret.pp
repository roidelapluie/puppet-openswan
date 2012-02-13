define openswan::secret (
  $ip,
  $secret
) {
  file {
    "/etc/openswan/ipsec.d/$name.secrets":
      ensure  => present,
      content => "${ip} %any 0.0.0.0: PSK \"${secret}\"",
      require => Package['openswan'],
  }
}
