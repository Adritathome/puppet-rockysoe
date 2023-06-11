# @summary 
#   completes CIS control 1.1.1.1 Ensure mounting of cramfs filesystems is disabled (Automated)
#
class rockysoe::cramfs {
  file { '/etc/modprobe.d':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { '/etc/modprobe.d/cramfs.conf':
    ensure  => file,
    source  => 'puppet:///modules/rockysoe/cramfs.conf',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => File['/etc/modprobe.d'],
  }

  exec { 'unload_cramfs':
    command => 'modprobe -r cramfs',
    path    => '/usr/bin:/usr/sbin:/bin:/sbin',
    unless  => 'lsmod | grep cramfs',
  }
}
