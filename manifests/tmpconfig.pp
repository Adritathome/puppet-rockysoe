# @summary 
#   completes CIS control 1.1.2.1 Ensure /tmp is a separate partition (Automated)
#   completes CIS control 1.1.2.2 Ensure nodev option set on /tmp partition (Automated)
#   completes CIS control 1.1.2.3 Ensure noexec option set on /tmp partition (Automated)
#   completes CIS control 1.1.2.4 Ensure nosuid option set on /tmp partition (Automated)
class rockysoe::tmpconfig {
  exec { 'get_uuid':
    command     => 'blkid -s UUID -o value /dev/sda1 /dev/sda2',  # Add additional block devices as needed
    path        => '/usr/bin:/bin',
    refreshonly => true,
    returns     => [0],
    environment => 'BLOCK_DEVICE_UUID_SDA1=%{facts[block_device_uuid_sda1]} BLOCK_DEVICE_UUID_SDA2=%{facts[block_device_uuid_sda2]}',
    notify      => File['/etc/fstab'],
  }

  # Create the systemd unit file for tmp.mount
  file { '/etc/systemd/system/tmp.mount':
    ensure => file,
    source => 'puppet:///modules/rockysoe/tmp.mount',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    notify => Exec['systemctl_reload'],
  }

  # Reload systemd configuration when the unit file changes
  exec { 'systemctl_reload':
    command     => '/bin/systemctl daemon-reload',
    refreshonly => true,
  }

  # Ensure fstab file is present and uses the template fstab.erb to populate
  file { '/etc/fstab':
    ensure  => file,
    content => template('rockysoe/fstab.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Exec['get_uuid'],
  }

  # Enable the tmp.mount unit at boot time
  exec { 'enable_tmp_mount':
    command     => '/bin/systemctl enable tmp.mount',
    refreshonly => true,
    require     => Exec['systemctl_reload'],
  }
}
