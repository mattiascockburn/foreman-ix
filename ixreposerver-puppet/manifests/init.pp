class ixreposerver() inherits ixreposerver::params {
	include ixreposerver::aptmirror
	include ixreposerver::webserver
	include ixreposerver::mrepo
	package { $reposerver_packages:
		ensure => present,
	}
	file { '/usr/local/bin/reposerver-update':
		ensure => present,
		source => "puppet:///modules/ixreposerver/reposerver-update",
		owner => 'root',
		group => 'root',
		mode => '0755',
	}
	exec { '/usr/local/bin/reposerver-update':
		subscribe => File['/usr/local/bin/reposerver-update'],
		refreshonly => true,
	}
	file { '/etc/debian-puppet-deps':
		ensure => present,
		source => "puppet:///modules/ixreposerver/debian-puppet-deps",
		owner => 'root',
		group => 'root',
		mode => '0644',
	}
	cron { 'reposerver-cron':
                command => "/usr/local/bin/reposerver-update 1>/var/log/reposerver.log 2>&1",
                user    => root,
                hour    => 2,
                minute  => 0,
		require => File['/usr/local/bin/reposerver-update']
        }
	
}

