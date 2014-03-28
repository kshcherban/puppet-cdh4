# == Class cdh4::hbase::master
# Installs and configures Hbase master
#
class cdh4::hbase::master {
    Class['cdh4::hbase'] -> Class['cdh4::hbase::master']

    # install hbase package
    package { 'hbase-master':
        ensure => installed
    }
    package { 'hbase-thrift':
        ensure => installed
    }

    # run services
    service { 'hbase-master':
        ensure      => 'running',
        enable      => true,
        hasstatus   => true,
        hasrestart  => true,
        require     => Package['hbase-master']
    }
    service { 'hbase-thrift':
        ensure      => 'running',
        enable      => true,
        hasstatus   => true,
        hasrestart  => true,
        require     => [Package['hbase-thrift'], Service['hbase-master']]
    }
}
