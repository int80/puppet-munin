# enable ngnix site

class munin::nginx {
  include "nginx"
  
  nginx::site {
    "munin":
      domain => $fqdn,
      root => '/var/cache/munin/www';
  }
}
