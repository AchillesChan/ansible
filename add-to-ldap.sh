#!/bin/bash
   passcode=$1;
   expect -c "
        set timeout 2
        spawn  adcli join --login-user=user1 azure.somedomain
        expect Password
        send \"$passcode\r\"
        expect eof
        catch wait result;   ###获取 exit code
        exit [lindex \$result 3]"
;
