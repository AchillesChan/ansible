settings {
    insist = true,
    logfile = "/var/log/lsyncd.log",
    statusFile = "/var/log/lsyncd.stat",
    statusInterval = 2
}


sync {
    default.rsync,
    source="/root/backup",
    target="sac.50yc.com:/backup/serverConfig/HOSTNAME",
    delete = false,
    rsync = {
        rsh ="/usr/bin/ssh -i /root/.ssh/rsync_user_rsa -p 50022 -l syncbackup",
        compress = true,
        perms = ture,
        acls = true,
        xattrs = true,
        archive = true
    }
}
