# @summary 
#   completes CIS control 1.1.1.2 Ensure mounting of squashfs filesystems is disabled (Automated)
#
class rockysoe::squashfs {
  file { '/etc/modprobe.d':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { '/etc/modprobe.d/squashfs.conf':
    ensure  => file,
    source  => 'puppet:///modules/rockysoe/squashfs.conf',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => File['/etc/modprobe.d'],
  }

  exec { 'unload_squashfs':
    command => 'modprobe -r squashfs',
    path    => '/usr/bin:/usr/sbin:/bin:/sbin',
    unless  => 'lsmod | grep squashfs',
  }
}
