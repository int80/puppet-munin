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
    "/etc/munin/plugins/pysysinfo":
      source => "puppet:///modules/munin/pymunin/pysysinfo",
      recurse => true;
    "/etc/munin/plugins/pymunin":
      source => "puppet:///modules/munin/pymunin/plugins/pymunin",
      recurse => true;

    # pymunin checks
    "/etc/munin/plugins/memcachedstats":
      source => "puppet:///modules/munin/pymunin/plugins/memcachedstats.py";
    "/etc/munin/plugins/diskiostats":
      source => "puppet:///modules/munin/pymunin/plugins/diskiostats.py";
    "/etc/munin/plugins/sysstats":
      source => "puppet:///modules/munin/pymunin/plugins/sysstats.py";

    # delete lame graphs
    [ "/etc/munin/plugins/df_inode", "/etc/munin/plugins/entropy",
      "/etc/munin/plugins/diskstats", "/etc/munin/plugins/iostat_ios",
      "/etc/munin/plugins/iostat", "/etc/munin/plugins/irqstats",
      "/etc/munin/plugins/open_inodes", "/etc/munin/plugins/interrupts",
      "/etc/munin/plugins/forks", "/etc/munin/plugins/load",
      "/etc/munin/plugins/proc_pri", "/etc/munin/plugins/vmstat",
      "/etc/munin/plugins/memory", "/etc/munin/plugins/open_files"]:
        notify => Service['munin-node'],
        ensure => absent;
  }
}
                                  
