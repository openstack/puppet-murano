# == Class: murano::policy
#
# Configure the murano policies
#
# === Parameters
#
# [*policies*]
#   (Optional) Set of policies to configure for murano
#   Example :
#     {
#       'murano-context_is_admin' => {
#         'key' => 'context_is_admin',
#         'value' => 'true'
#       },
#       'murano-default' => {
#         'key' => 'default',
#         'value' => 'rule:admin_or_owner'
#       }
#     }
#   Defaults to empty hash.
#
# [*policy_path*]
#   (Optional) Path to the murano policy.yaml file
#   Defaults to /etc/murano/policy.yaml
#
class murano::policy (
  $policies    = {},
  $policy_path = '/etc/murano/policy.yaml',
) {

  include murano::deps
  include murano::params

  validate_legacy(Hash, 'validate_hash', $policies)

  Openstacklib::Policy::Base {
    file_path   => $policy_path,
    file_user   => 'root',
    file_group  => $::murano::params::group,
    file_format => 'yaml',
  }

  create_resources('openstacklib::policy::base', $policies)

  oslo::policy { 'murano_config': policy_file => $policy_path }

}
