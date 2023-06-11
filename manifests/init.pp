# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   
class rockysoe (
  String $enforce_udf,
  String $enforce_squashfs,
  String $enforce_cramfs,
) {
  include rockysoe::unusedfs
}
