class ixreposerver::aptmirror() inherits ixreposerver::params {
	file { 'apt-mirror-binary':
		path => '/usr/local/bin/apt-mirror',
		ensure => present,
		source => 'puppet:///modules/ixreposerver/apt-mirror',
		mode => '0755',
		owner => 'root',
		group => 'root',
	}
	package { 'dpkg-devel':
		ensure => present,
	}
	file { '/etc/aptmirror.list':
		ensure => present,
		content => template('ixreposerver/aptmirror.list.erb'),
	}
	file { [ $apt_mirror_dir, $debian_iso_dir, $debian_iso_mount, $apt_gpg_dir, $puppetrepo_dir ]:
		ensure => directory,
	}
	mount { "$debian_iso_mount":
		device => "$debian_iso_file",
		fstype => iso9660,
		ensure => mounted,
		options => "loop",
		atboot => true,
		require => Exec['isodownload_deb'],
	}
	exec { 'isodownload_deb':
		command => "/bin/bash -c '/usr/bin/curl $debian_iso_mirror > $debian_iso_file'",
		creates => "$debian_iso_file",
		require => File[$debian_iso_dir],
	}
	exec { 'puppetlabs-gpgkey':
		command => "/bin/bash -c '/usr/bin/curl http://apt.puppetlabs.com/pubkey.gpg > $apt_gpg_dir/puppetlabs-apt.gpg'",
                creates => "$apt_gpg_dir/puppetlabs-apt.gpg",
                require => File[$apt_gpg_dir],
	}
}
