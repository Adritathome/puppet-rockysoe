# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   
class rockysoe (
  Boolean $enforce_udf = false,
  Boolean $enforce_squashfs = false,
  Boolean $enforce_cramfs = false,
  $boot_partition,
  $efi_partition,
) {
  include rockysoe::unusedfs
  class { 'rockysoe::tmpconfig':
    boot_partition => $boot_partition,
    efi_partition  => $efi_partition,
  }
}
