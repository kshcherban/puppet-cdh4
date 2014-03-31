#
# == Class cdh4::zookeeper
#
# Installs zookeeper client and configures Zookeeper ensemble
#
# == Parameters
#   $zookeeper_quorum       - Array of zookeeper hosts:ports that create quorum
#   $config_directory       - Path of zookeeper config directory
#   $client_conn_max        - Maximum client connections
#   $data_dir               - The directory where the snapshot is stored
#   $client_port            - The port at which the clients will connect
#   $session_timeout_min    - The minimum session timeout in milliseconds that the server will allow the client to negotiate
#   $session_timeout_max    - The maximum session timeout in milliseconds that the server will allow the client to negotiate
#   $tick_time              - The length of a single tick, which is the basic time unit used by ZooKeeper, as measured in milliseconds
#
#
class cdh4::zookeeper(
    $zookeeper_quorum       = $::cdh4::zookeeper::defaults::zookeeper_quorum,
    $config_directory       = $::cdh4::zookeeper::defaults::config_directory,
    $client_conn_max        = $::cdh4::zookeeper::defaults::client_conn_max,
    $data_dir               = $::cdh4::zookeeper::defaults::data_dir,
    $client_port            = $::cdh4::zookeeper::defaults::client_port,
    $tick_time              = $::cdh4::zookeeper::defaults::tick_time,
    $session_timeout_min    = $::cdh4::zookeeper::defaults::session_timeout_min,
    $session_timeout_max    = $::cdh4::zookeeper::defaults::session_timeout_max
) inherits cdh4::zookeeper::defaults
{
    # Install zookeeper client
    package { 'zookeeper':
        ensure => 'installed'
    }
    # Zookeeper configuration
    file {"${config_directory}/zoo.cfg":
        content => template('cdh4/zookeeper/zoo.cfg.erb')
    }
}
