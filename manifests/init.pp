# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   
class rockysoe (
  Boolean $enforce_udf,
  Boolean $enforce_squashfs,
  Boolean $enforce_cramfs,
) {
  include rockysoe::unusedfs
}
