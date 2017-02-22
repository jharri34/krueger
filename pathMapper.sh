#!/bin/bash

DATADIR=$1
if [ -z $DATADIR ]; then
  echo "Usage: pathMapper [DATA-DIRECTORY] [-u username][-p password][-d database] [-t table] [-h help] [-c column]"
  exit
fi

for i in "$@"
do
  case $i in
    -u=*|--username=*)
    USERNAME="${i#*=}"
    shift
    ;;
    -p=*|--password=*)
    PASSWORD="${i#*=}"
    shift
    ;;
    -h|--help)
    echo "Usage: sh pathMapper <DATA-DIRECTORY> <METADATA> [-p password] [-u username] [-d database] [-t table] [-h help] [-c column]"
    shift
    ;;
    -d=*|--database=*)
    DATABASE="${i#*=}"
    shift
    ;;
    -t=*|--table=*)
    TABLE_NAME="${i#*=}"
    shift
    ;;
    -c=*|--column=*)
    COLUMN_NAME="${i#*=}"
    shift
    ;;
    --default)
    USERNAME="root"
    PASSWORD="password"
    shift
    ;;
    *)
  esac
done


OIFS="$IFS"
IFS="
"
SAMPLES=($(mysql -D$DATABASE -u$USERNAME -p$PASSWORD -se "SELECT sample FROM $TABLE_NAME WHERE $COLUMN_NAME IS NULL;"))
IFS="$OIFS"
UPDATES=()
for SAMPLE in "${SAMPLES[@]}"; do
  mysql -D$DATABASE -u$USERNAME -p$PASSWORD -se "UPDATE $TABLE_NAME SET $COLUMN_NAME='$(find "$DATADIR" -name "${SAMPLE}.*")' WHERE sample='$SAMPLE' AND $COLUMN_NAME IS NULL;"
done
I
#do
#  FILEPATH=$(find $DATADIR -name "$sample.*")
#  echo "this is what i want t$FILEPATH"
#done | mysql -D$DATABASE -u$USERNAME -p$PASSWORD -se "SELECT sample FROM $TABLE_NAME WHERE $COLUMN_NAME IS NULL;"

# for file in "$DATADIR"/*
# do
#   FULLPATH=$file
#   FILE=${file##*/}
#   FILENAME=${FILE%%.*}
#   EXT=${file##*.}
# done
