class { 'nginx': }
include ruby::dev

nginx::resource::upstream { 'facts_rack_app':
  members => [
    'unix:/var/run/factcollector-unicorn.sock',
  ],
}

nginx::resource::vhost { 'facts.whilefork.com':
  proxy => 'http://facts_rack_app',
}

ruby::bundle { 'factcollector':
  cwd     => '/opt/factcollector',
  require => Vcsrepo['/opt/factcollector'],
}

unicorn::app { 'factcollector':
  approot     => '/opt/factcollector',
  pidfile     => '/var/run/factcollector-unicorn.pid',
  socket      => '/var/run/factcollector-unicorn.sock',
  user        => 'www-data',
  group       => 'www-data',
  preload_app => true,
  rack_env    => 'production',
  source      => 'bundler',
  require     => [
    Class['ruby::dev'],
    Ruby::Bundle['factcollector'],
    Vcsrepo['/opt/factcollector'],
  ],
}

file { '/opt/uploads':
  ensure => 'directory',
  owner  => 'www-data',
  group  => 'www-data',
}

package { 'git':
  ensure => present
}

vcsrepo { "/opt/factcollector":
  ensure   => present,
  provider => git,
  source   => 'https://github.com/danieldreier/factcollector.git',
  notify   => Service['unicorn_factcollector'],
}
