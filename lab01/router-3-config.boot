interfaces {

    /* lan7 */
    ethernet PLACEHOLDER_02:42:07:01:00:02 {
        address 7.1.0.2/16
        duplex auto
        smp_affinity auto
        speed auto
    }

    loopback lo {
    }
}
service {
    ssh {
        listen-address 0.0.0.0
        port 22
    }
}
protocols {
    /* static {
        route 0.0.0.0/0 {
            next-hop 8.1.0.102 {
                distance 1
            }
        }
    } */
}
system {
    config-management {
        commit-revisions 20
    }
    console {
        device ttyS0 {
            speed 9600
        }
    }
    host-name vyos
    login {
        user vyos {
            authentication {
                encrypted-password $1$5HsQse2v$VQLh5eeEp4ZzGmCG/PRBA1
            }
            level admin
        }
    }
    ntp {
        server 0.pool.ntp.org {
        }
        server 1.pool.ntp.org {
        }
        server 2.pool.ntp.org {
        }
    }
    package {
        auto-sync 1
        repository community {
            components main
            distribution helium
            password ""
            url http://packages.vyos.net/vyos
            username ""
        }
    }
    syslog {
        global {
            facility all {
                level notice
            }
            facility protocols {
                level debug
            }
        }
    }
    time-zone UTC
}


/* Warning: Do not remove the following line. */
/* === vyatta-config-version: "cluster@1:vrrp@1:conntrack@1:webproxy@1:ipsec@4:wanloadbalance@3:quagga@2:firewall@5:dhcp-server@4:nat@4:system@6:zone-policy@1:dhcp-relay@1:qos@1:webgui@1:conntrack-sync@1:cron@1:config-management@1" === */
/* Release version: VyOS 1.1.1 */