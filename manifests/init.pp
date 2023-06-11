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
) {
  include rockysoe::unusedfs
}
