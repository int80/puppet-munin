class munin::host {
  package {
    "munin":
      ensure => installed;
  }
}
