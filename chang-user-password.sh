#!/bin/bash
   username=$1;
   newpass=$2;
   export HISTIGNORE="expect*";
   expect -c "
        set timeout 5
        spawn passwd $username
        expect "?assword:"
    
        send \"$newpass\r\"
        expect "?assword:"
        send \"$newpass\r\"
        expect eof"
  export HISTIGNORE="";
