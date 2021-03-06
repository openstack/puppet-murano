#
# Class to execute murano dbsync
#
# ==Parameters
#
# [*db_sync_timeout*]
#   (Optional) Timeout for the execution of the db_sync
#   Defaults to 300
#
class murano::db::sync(
  $db_sync_timeout = 300,
) {

  include murano::deps
  include murano::params

  exec { 'murano-dbmanage':
    command     => $::murano::params::dbmanage_command,
    path        => '/usr/bin',
    user        => 'murano',
    refreshonly => true,
    try_sleep   => 5,
    tries       => 10,
    timeout     => $db_sync_timeout,
    logoutput   => on_failure,
    subscribe   => [
      Anchor['murano::install::end'],
      Anchor['murano::config::end'],
      Anchor['murano::dbsync::begin']
    ],
    notify      => Anchor['murano::dbsync::end'],
    tag         => 'openstack-db',
  }

}
