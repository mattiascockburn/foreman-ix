class ixreposerver::mrepo() inherits ixreposerver::params {
	file { '/etc/mrepo.conf.d/centos6.conf':
		ensure => present,
		source => "puppet:///modules/ixreposerver/mrepo.conf.d.centos6",
		require => Package['mrepo']
	}
	package { ["mrepo", "lftp", "createrepo" ]:
		ensure => present,
		require => Package['epel-release'],
	}
	package { 'epel-release':
		provider => 'rpm',
		ensure => present,
		source => "http://mirror.fraunhofer.de/dl.fedoraproject.org/epel/6/x86_64/epel-release-6-8.noarch.rpm",
	}
	exec { 'isodownload-centos':
		command => "/bin/bash -c '/usr/bin/curl ${centos_iso_mirror} > ${mrepo_dir}/${centos_iso_file}'",
		creates => "${mrepo_dir}/${centos_iso_file}",
		require => Package['mrepo'],
	}
			
}

