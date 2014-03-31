# == Class cdh4::zookeeper::defaults
# Default parameters for cdh4::zookeeper configuration
#
class cdh4::zookeeper::defaults {
    $zookeeper_quorum       = undef
    $config_directory       = '/etc/zookeeper/conf'
    $client_conn_max        = 50
    $data_dir               = '/var/lib/zookeeper'
    $client_port            = 2181
    $tick_time              = 2000
    $session_timeout_min    = 4000
    $session_timeout_max    = 40000
}
