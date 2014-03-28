# == Class cdh4::hbase::regionserver
# Installs and configures Hbase RegionServer
#
class cdh4::hbase::regionserver {
    Class['cdh4::hbase'] -> Class['cdh4::hbase::regionserver']

    # install and run regionserver
    package { 'hbase-regionserver':
        ensure => installed
    }
    service { 'hbase-regionserver':
        ensure      => 'running',
        enable      => true,
        hasstatus   => true,
        hasrestart  => true,
        require     => Package['hbase-regionserver']
    }
    # install and run thrift if not defined earlier
    if (!defined(Package['hbase-thrift'])) {
            package { 'hbase-thrift':
                ensure => installed
            }
            service { 'hbase-thrift':
                ensure      => 'running',
                enable      => true,
                hasstatus   => true,
                hasrestart  => true,
                require     => [Package['hbase-thrift'], Service['hbase-regionserver']]
            }
    }
}
