#! /bin/sh

export R_HOME=`R RHOME`
export QHOME=$(cd `dirname $0` && pwd)
export LD_LIBRARY_PATH=$QHOME
export initScript=$QHOME/../qinfra.q

$QHOME/q $initScript "$@"
