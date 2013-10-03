class ixreposerver::params {
  case $::osfamily {
    'RedHat': {
	case $::lsbmajdistrelease {
		'6': {
			$webserver_package = 'httpd'
			$reposerver_packages = $webserver_package
			$webserver_confdir = "/etc/httpd/conf.d"
			$apt_mirror_webdir = "/var/www/apt"
			$apt_mirror_dir = "/var/apt"
			$apt_gpg_dir = "${apt_mirror_dir}/gpg"
			$puppetrepo_dir = [ "${apt_mirror_dir}/mirror", "${apt_mirror_dir}/mirror/puppet-deps" ] 
			$debian_iso_dir = "${apt_mirror_dir}/iso"
			$debian_release = "7.1.0"
			$debian_arch = "amd64"
			$debian_iso_name = "debian-${debian_release}-${debian_arch}-DVD-1"
			$debian_iso_mount = "${debian_iso_dir}/${debian_iso_name}"
			$debian_iso_file = "${debian_iso_dir}/${debian_iso_name}.iso"
			$debian_iso_mirror = "http://cdimage.debian.org/debian-cd/${debian_release}/${deban_arch}/iso-dvd/${debian_iso_name}.iso"
			$mrepo_dir = "/var/mrepo"
			$centos_release = "6.4"
			$centos_arch = "x86_64"
			$centos_iso_file = "CentOS-${centos_release}-${centos_arch}-bin-DVD1.iso"
			$centos_iso_mirror = "http://centos.bio.lmu.de/${centos_release}/isos/${centos_arch}/${centos_iso_file}"
		}
		default: {
			fail("Sorry, only tested on RHEL6")
		}
	}
    }
    default: {
      fail("Unsupported platform: ${::osfamily}")
    }
    }
}
