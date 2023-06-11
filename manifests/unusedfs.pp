# @summary 
#   completes CIS control 1.1.1.1 Ensure mounting of cramfs filesystems is disabled (Automated)
#   completes CIS control 1.1.1.2 Ensure mounting of squashfs filesystems is disabled (Automated)
#
class rockysoe::unusedfs (
  $enforce_cramfs   = true,
  $enforce_squashfs = true,
  $enforce_udf      = true,
) {
  file { '/etc/modprobe.d':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  if $enforce_cramfs {
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
      unless  => 'lsmod | grep -c cramfs',
    }
  }

  if $enforce_squashfs {
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
      unless  => 'lsmod | grep -c squashfs',
    }
  }

  if $enforce_udf {
    file { '/etc/modprobe.d/udf.conf':
      ensure  => file,
      source  => 'puppet:///modules/rockysoe/udf.conf',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => File['/etc/modprobe.d'],
    }

    exec { 'unload_udf':
      command => 'modprobe -r udf',
      path    => '/usr/bin:/usr/sbin:/bin:/sbin',
      unless  => 'lsmod | grep -c udf',
    }
  }
}
