# == Class cdh4::hbase::regionserver
# Installs and configures Hbase RegionServer
#
class cdh4::hbase::regionserver {
    Class['cdh4::hbase'] -> Class['cdh4::hbase::regionserver']

    # install hbase package
    package { 'hbase-regionserver':
        ensure => installed
    }
    package { 'hbase-thrift':
        ensure => installed
    }

    # run services
    service { 'hbase-regionserver':
        ensure      => 'running',
        enable      => true,
        hasstatus   => true,
        hasrestart  => true,
        require     => Package['hbase-regionserver']
    }
    service { 'hbase-thrift':
        ensure      => 'running',
        enable      => true,
        hasstatus   => true,
        hasrestart  => true,
        require     => [Package['hbase-thrift'], Service['hbase-regionserver']]
    }
}
