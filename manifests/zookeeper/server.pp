# == Class cdh4::zookeeper::server
# Installs and configures Zookeeper server which is a part of ensemble
#
#
class cdh4::zookeeper::server {
    Class['cdh4::zookeeper'] -> Class['cdh4::zookeeper::server']

    # install package
    package { 'zookeeper-server':
        ensure => installed
    }
    $zookeeper_quorum   = $::cdh4::zookeeper::zookeeper_quorum
    $data_dir           = $::cdh4::zookeeper::data_dir
    # initial execution
    exec { 'zookeeper-init':
        command => '/sbin/service zookeeper-server init',
        creates => "${data_dir}/version-2",
        require => Package['zookeeper-server']
    }
    # file myid with unique id
    file {
        "${data_dir}":
            ensure  => directory,
            mode    => '0750',
            owner   => 'zookeeper',
            group   => 'zookeeper';
        "${data_dir}/myid":
            content => template('cdh4/zookeeper/myid.erb'),
            mode    => '0644',
            owner   => 'zookeeper',
            group   => 'zookeeper',
            require => Exec['zookeeper-init']
    }
    # run service
    service { 'zookeeper-server':
        ensure     => 'running',
        enable     => true,
        hasstatus  => true,
        hasrestart => true,
        require    => File["${data_dir}/myid"]
    }
}
