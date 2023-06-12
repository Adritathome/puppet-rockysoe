# @summary 
#   completes CIS control 1.1.2.1 Ensure /tmp is a separate partition (Automated)
#   completes CIS control 1.1.2.2 Ensure nodev option set on /tmp partition (Automated)
#   completes CIS control 1.1.2.3 Ensure noexec option set on /tmp partition (Automated)
#   completes CIS control 1.1.2.4 Ensure nosuid option set on /tmp partition (Automated)
class rockysoe::tmpconfig (
  $block_device_uuid_sda1 = inline_template('<%= `/sbin/blkid -s UUID -o value /dev/sda1`.strip %>')
  $block_device_uuid_sda2 = inline_template('<%= `/sbin/blkid -s UUID -o value /dev/sda2`.strip %>')

) {
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
    require => File['/etc/systemd/system/tmp.mount'],
  }

  # Enable the tmp.mount unit at boot time
  exec { 'enable_tmp_mount':
    command     => '/bin/systemctl enable tmp.mount',
    refreshonly => true,
    require     => Exec['systemctl_reload'],
  }
}
