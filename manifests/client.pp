class munin::client {
  package {
    "munin-node":
      ensure => installed;
  }
  
  service {
    "munin-node":
      ensure => running,
      hasstatus => false,
      require => Package['munin-node'],
      enable => true;
  }

  file {
    # munin node config
    "/etc/munin/plugin-conf.d/int80":
      notify => Service['munin-node'],
      source => "puppet:///modules/munin/int80.conf";
    "/etc/munin/munin-node.conf":
      notify => Service['munin-node'],
      content => template("munin/munin-node.conf.erb");

    # memcached check config
    "/etc/munin/plugin-conf.d/memcached":
      content => template("munin/memcached-conf.erb");

    # pymunin
    "/usr/local/lib/python2.6/site-packages/pysysinfo":
      source => "puppet:///modules/munin/pymunin/pysysinfo",
      recurse => true;
    "/usr/local/lib/python2.6/site-packages/pymunin":
      source => "puppet:///modules/munin/pymunin/plugins/pymunin",
      recurse => true;

    # pymunin checks
    "/etc/munin/plugins/memcachedstats":
      source => "puppet:///modules/munin/pymunin/plugins/memcachedstats.py";
    "/etc/munin/plugins/diskiostats":
      source => "puppet:///modules/munin/pymunin/plugins/diskiostats.py";
    "/etc/munin/plugins/sysstats":
      source => "puppet:///modules/munin/pymunin/plugins/sysstats.py";
  }
}
                                  
