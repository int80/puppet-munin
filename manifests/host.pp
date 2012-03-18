class munin::host {
  package {
    "munin":
      ensure => installed;
  }

  file {
    "/etc/munin/munin-conf.d/slaves.conf":
      source => "puppet:///munin/slaves.conf";
  }
}
