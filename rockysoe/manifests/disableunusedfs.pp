# @summary 
#   completes CIS control 1.1.1.1 Ensure mounting of cramfs filesystems is disabled (Automated)
#
class disableunusedfs::cramfs {
  file { '/etc/modprobe.d':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { '/etc/modprobe.d/cramfs.conf':
    ensure  => file,
    content => 'install cramfs /bin/false\nblacklist cramfs\n',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => File['/etc/modprobe.d'],
  }
}
