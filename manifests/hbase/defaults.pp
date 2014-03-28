# == Class cdh4::hbase::defaults
# Default parameters for cdh4::hbase configuration.
#
class cdh4::hbase::defaults {
    $config_directory       = '/etc/hbase/conf'
    $hbase_root_dir         = '/hbase'

    $region_size            = '107374182400'

    $compaction_maj_time    = '172800000'
    $compaction_maj_size    = '6442450944'
    $compaction_min_max     = '10'
    $compaction_min_size    = '2147483648'

    $rpc_timeout            = '1800000'

    $zookeeper_datadir      = '/var/zookeeper'
    $zookeeper_znode_parent = '/hbase'
    $zookeeper_timeout      = '1200000'

    $regionserver_maxlogs   = '32'
    $regionserver_lease     = '1800000'
    $regionserver_logroll   = '3600000'
    $regionserver_handlers  = '40'

    $ganglia_hosts          = undef

    $env_heapsize           = '1000'
    $env_javaopts           = undef
}
