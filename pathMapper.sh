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

for file in "$DATADIR"/*
do
  FULLPATH=$file
  FILE=${file##*/}
  FILENAME=${FILE%%.*}
  EXT=${file##*.}

  # echo "fullpath:$FULLPATH"
  # echo "file:$FILE"
  # echo "filename:$FILENAME"
  # echo "extension:$EXT"
done
result = $(mysql -d$DATABASE -u$USERNAME -p$PASSWORD -se "SELECT profile,sample WHERE resource IS NOT NULL")
echo $result
# "SELECT NOT EXISTS (SELECT * FROM $TABLE_NAME WHERE sample=$FILENAME)
# \BEGIN ALTER $TABLE_NAME ADD "
# "IF EXISTS (SELECT * FROM INFOMATION_SCHEMA.COLUMNS \
# WHERE TABLE_NAME='$TABLE_NAME' AND COLUMN_NAME='$COLUMN_NAME')\
# BEGIN\
# ALTER TABLE $TABLE_NAME ADD $COLUMN_NAME VARCHAR(255)" | mysql -u$USERNAME -p$PASSWORD $DATABASE;
