# enable ngnix site

class munin::nginx {
  nginx::site {
    "munin":
      domain => $fqdn,
      root => '/var/cache/munin/www';
  }
}
