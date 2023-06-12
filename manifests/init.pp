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
  String  $boot_partition = '',
  String  $efi_partition  = '',
) {
  include rockysoe::unusedfs
  include rockysoe::tmpconfig
}
