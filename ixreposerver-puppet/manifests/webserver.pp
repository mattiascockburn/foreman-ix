class ixreposerver::webserver() inherits ixreposerver::params {
    file { "${webserver_confdir}/aptmirror.conf":
      ensure  => file,
      require => Package[$webserver_package],
      content => template('ixreposerver/aptmirror.conf.erb'),
      owner => 'root',
      group => 'root',
      mode => '0644',
      notify => Service[$webserver_package],
    }
    service { "$webserver_package":
	ensure => running,
	enable => true,
	}
}
