#! /bin/sh

export R_HOME=`R RHOME`
export QHOME=$(cd `dirname $0` && pwd)
export LD_LIBRARY_PATH=/usr/lib:$QHOME
export initScript=$QHOME/../qinfra.q
export SSL_CERT_FILE=$HOME/certs/server-crt.pem
export SSL_KEY_FILE=$HOME/certs/server-key.pem
export SSL_VERIFY_SERVER=NO

$QHOME/q $initScript "$@"
