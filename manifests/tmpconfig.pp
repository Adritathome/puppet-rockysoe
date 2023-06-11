# @summary 
#   completes CIS control 1.1.2.1 Ensure /tmp is a separate partition (Automated)
#   completes CIS control 1.1.1.2 Ensure mounting of squashfs filesystems is disabled (Automated)
#   completes CIS control 1.1.1.3 Ensure mounting of udf filesystems is disabled (Automated)   
class rockysoe::tmpconfig {
  # Create the systemd unit file for tmp.mount
  file { '/etc/systemd/system/tmp.mount':
    ensure  => file,
    content => "[Unit]\nDescription=Temporary Directory\nDocumentation=man:hier(7)\nDocumentation=http://www.freedesktop.org/wiki/Software/systemd/APIFileSystems\n\n[Mount]\nWhat=tmpfs\nWhere=/tmp\nType=tmpfs\nOptions=rw,nosuid,nodev,noexec,relatime,seclabel,size=2G\n\n[Install]\nWantedBy=multi-user.target\n",
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Exec['systemctl_reload'],
  }

  # Reload systemd configuration when the unit file changes
  exec { 'systemctl_reload':
    command     => 'systemctl daemon-reload',
    refreshonly => true,
  }

  # Update the /etc/fstab file with the tmpfs entry
  file { '/etc/fstab':
    ensure  => file,
    content => "tmpfs /tmp tmpfs defaults,rw,nosuid,nodev,noexec,relatime,size=2G 0 0\n",
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => File['/etc/systemd/system/tmp.mount'],
  }

  # Enable the tmp.mount unit at boot time
  exec { 'enable_tmp_mount':
    command     => 'systemctl enable tmp.mount',
    refreshonly => true,
    require     => Exec['systemctl_reload'],
  }
}
