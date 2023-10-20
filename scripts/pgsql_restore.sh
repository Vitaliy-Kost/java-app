#!/bin/bash

#change on your path to PostgreSQL
pathA=/c/Program\ Files/PostgreSQL/13/bin
#export PATH=$PATH:$pathA

#write your password
PGPASSWORD="D52PuG70kx(E?}evtAe03wl2b1JbF(R6"
export PGPASSWORD

#change the path to the file from which will be made restore
pathB=../backup/2023-09-07.dump
#write this on the command line as the first parameter
filename=$1
#write your user
dbUser=schedule
#write your database
database=schedule
#write your host
host=localhost
#write your port
port=5432

psql -U $dbUser -h $host -p $port -d $database -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;"

psql --set ON_ERROR_STOP=off -U $dbUser -h $host -p $port -d $database -1 -f $pathB$filename

unset PGPASSWORD

psql -U postgres -d schedule -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;"
psql --set ON_ERROR_STOP=off -U postgres -d schedule -1 -f 2023-09-07.dump