# enable ngnix site

class munin::nginx {
  include webserver
  
  nginx::site {
    "munin":
      domain => "munin.$::domain",
      root => '/var/cache/munin/www';
  }
}
