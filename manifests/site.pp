hiera_include('classes',[])

node default {}

node 'zy-puppetmaster.buildandrelease.org' {
	class { 'ntp':
		servers => [ 'ntp1.corp.com', 'ntp2.corp.com' ],
	}
}

node 'zy-puppetslave.buildandrelease.org' {
	include '::ntp'
	user { 'zcapili' :
		ensure => 'present',
	}
	package { 'nano':
		ensure => '2.3.1-10.el7',
	}
	user { 'read only user' :
		name => 'voyuer',
                ensure => 'present',
        }
	class { 'profile::release_accounts' :
		ensure => 'present',

	 }
	include ::role::webserver
}

node 'zy-wordpress1.buildandrelease.org' {
	include '::ntp'
	include ::role::amp
	include ::profile::wordpress
}

node 'zy-wordpress2.buildandrelease.org' {
	include ::role::amp
	include ::profile::wordpress
}
