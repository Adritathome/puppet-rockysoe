# @summary 
#   completes CIS control 1.1.1.1 Ensure mounting of cramfs filesystems is disabled (Automated)
#
class rockysoe::cramfsunload {
  exec { 'unload_cramfs':
    command => 'modprobe -r cramfs',
    path    => '/usr/bin:/usr/sbin:/bin:/sbin',
    unless  => 'lsmod | grep cramfs',
  }
}
