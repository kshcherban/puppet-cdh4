# == Class cdh4::hbase::master
# Installs and configures Hbase master
#
class cdh4::hbase::master {
    Class['cdh4::hbase']    -> Class['cdh4::hbase::master']

    # install hbase package
    package { 'hbase-master':
        ensure => installed
    }
    package { 'hbase-thrift':
        ensure => installed
    }

    $hbase_root_dir = $::cdh4::hbase::hbase_root_dir

    # sudo -u hdfs hadoop fs -mkdir /hbase
    cdh4::hadoop::directory { $hbase_root_dir:
        owner   => 'hbase',
        group   => 'hdfs',
        mode    => '0755',
        require => Package['hbase-master']
    }

    # run services
    service { 'hbase-master':
        ensure      => 'running',
        enable      => true,
        hasstatus   => true,
        hasrestart  => true,
        require     => Cdh4::Hadoop::Directory[$hbase_root_dir]
    }
    service { 'hbase-thrift':
        ensure      => 'running',
        enable      => true,
        hasstatus   => true,
        hasrestart  => true,
        require     => [Package['hbase-thrift'], Service['hbase-master']]
    }
}
