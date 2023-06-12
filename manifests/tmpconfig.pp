# @summary 
#   completes CIS control 1.1.2.1 Ensure /tmp is a separate partition (Automated)
class rockysoe::tmpconfig {
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

  # Ensure fstab file is present
  file { '/etc/fstab':
    ensure => file,
    source => 'puppet:///modules/rockysoe/fstab',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  # Enable the tmp.mount unit at boot time
  exec { 'enable_tmp_mount':
    command     => '/bin/systemctl enable tmp.mount',
    refreshonly => true,
    require     => Exec['systemctl_reload'],
  }
}
