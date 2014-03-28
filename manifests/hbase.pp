#
# == Class cdh4::hbase
#
# Installs the main Hbase master and Regionserver packages and files
# By default this manifest does not install anything it's used for configuration only
# Refer to manifets/hbase/master.pp,regionserver.pp for installation
#
# == Parameters
#   $regionservers              - Array of regionservers
#   $defaultfs_uri              - The name and URI of the default FS (fs.defaultFS)
#   $hbase_root_dir             - The directory shared by region servers in HDFS
#   $region_size                - Maximum HStoreFile size in bytes
#   $compaction_maj_time        - The time (in miliseconds) between major compactions
#   $compaction_maj_size        - Any StoreFile larger than this setting with automatically be excluded from compaction
#   $compaction_min_max         - Max number of HStoreFiles to compact per minor compaction
#   $compaction_min_size        - Size limit in bytes of files compacted by minor compact
#   $rpc_timeout                - Timeout of internal HBase RPC calls in miliseconds
#   $zookeeper_quorum           - Array of zookeeper hosts that create quorum
#   $zookeeper_datadir
#   $zookeeper_znode_parent
#   $zookeeper_timeout          - Zookeeper timeout specified in milliseconds
#   $regionserver_maxlogs       - Maximum amount of WAL log files kept in memory
#   $regionserver_lease         - HRegion server lease period in milliseconds
#   $regionserver_logroll       - Interval in miliseconds between log roll attempts
#   $regionserver_handlers      - The number of threads that are kept open to answer incoming requests to user tables
#   $ganglia_hosts              - Set this to an array of ganglia host:ports
#                         if you want to enable ganglia sinks in hadoop-metrics.properites
#   $env_heapsize               - hbase-env.sh heap size var in megabytes
#   $env_javaopts               - hbase-env.sh heap java options, string
#
#
class cdh4::hbase(
    $regionservers,
    $defaultfs_uri,
    $zookeeper_quorum,
    $config_directory       = $::cdh4::hbase::defaults::config_directory,
    $hbase_root_dir         = $::cdh4::hbase::defaults::hbase_root_dir,
    $region_size            = $::cdh4::hbase::defaults::region_size,
    $compaction_maj_time    = $::cdh4::hbase::defaults::compaction_maj_time,
    $compaction_min_size    = $::cdh4::hbase::defaults::compaction_min_size,
    $compaction_min_max     = $::cdh4::hbase::defaults::compaction_min_max,
    $rpc_timeout            = $::cdh4::hbase::defaults::rpc_timeout,
    $zookeeper_datadir      = $::cdh4::hbase::defaults::zookeeper_datadir,
    $zookeeper_znode_parent = $::cdh4::hbase::defaults::zookeeper_znode_parent,
    $zookeeper_timeout      = $::cdh4::hbase::defaults::zookeeper_timeout,
    $regionserver_maxlogs   = $::cdh4::hbase::defaults::regionserver_maxlogs,
    $regionserver_lease     = $::cdh4::hbase::defaults::regionserver_lease,
    $regionserver_logroll   = $::cdh4::hbase::defaults::regionserver_logroll,
    $regionserver_handlers  = $::cdh4::hbase::defaults::regionserver_handlers,
    $ganglia_hosts          = $::cdh4::hbase::defaults::ganglia_hosts,
    $env_heapsize           = $::cdh4::hbase::defaults::env_heapsize,
    $env_javaopts           = $::cdh4::hbase::defaults::env_javaopts
) inherits cdh4::hbase::defaults
{
    package { 'hbase':
        ensure => 'installed'
    }

    # All config files require hbase package.
    File {
        require => Package['hbase']
    }

    file { "${config_directory}/hbase-env.sh":
        content => template('cdh4/hbase/hbase-env.sh.erb'),
    }

    # Render hadoop-metrics.properties
    # if we have Ganglia Hosts to send metrics to.
    $hadoop_metrics_ensure = $ganglia_hosts ? {
        undef   => 'absent',
        default => 'present',
    }
    file { "${config_directory}/hadoop-metrics.properties":
        ensure  => $hadoop_metrics_ensure,
        content => template('cdh4/hbase/hadoop-metrics.properties.erb'),
    }

    file { "${config_directory}/hbase-site.xml":
        content => template('cdh4/hbase/hbase-site.xml.erb'),
    }

    # File with regionservers
    file { "${config_directory}/regionservers":
        content => template('cdh4/hbase/regionservers.erb')
    }

    file { "${config_directory}/log4j.properties":
        content => template('cdh4/hbase/log4j.properties.erb'),
    }
}
