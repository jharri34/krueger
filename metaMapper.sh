#!/bin/bash
DATADIR=$1
METADATA=$2
OLDIFS=$IFS
IFS=,

if [ -z "$DATADIR" ]; then
  echo "\nno data directory was given.\nusage: sh metaMapper <DATA-DIRECTORY> <METADATA>[-p password] [-u username] [-d DATABASE] [-h help]";
  exit
fi
if [ -z "$METADATA" ]; then
  metatData=`find $DATADIR -type f -name "*.csv"`
  if [ -z "$METADATA"]; then
    echo "\nno meta-data file given.\nusage: sh metaMapper <DATA-DIRECTORY> <METADATA>[-p password] [-u username] [-d DATABASE] [-h help]";
    exit
  fi
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
    echo "Usage: sh metaMapper <DATA-DIRECTORY> <METADATA> [-p password] [-u username] [-d DATABASE] [-h help]"
    shift
    ;;
    -d=*|--database=*)
    DATABASE="${i#*=}"
    shift
    ;;
    -t=*|--table=*)
    TABLE="${i#*=}"
    shift
    ;;
    --default)
    USERNAME="root"
    PASSWORD="password"
    shift # past argument with no value
    ;;
    *)
  esac
done
echo "USERNAME:$USERNAME"
echo "PASSWORD:$PASSWORD"
echo "DATABASE:$DATABASE"
echo "TABLE:$TABLE"

[ ! -f $METADATA ] & cat $METADATA | while read id attachment state ploidy
do
  # echo "id:$id";
  # echo "attachment:$attachment"
  # echo "state:$state"
  # echo "ploidy:$ploidy"
  echo "INSERT INTO $TABLE (sample, attachment, state, ploidy) VALUES ($id, $attachment, $state, $ploidy);"
done | mysql -u$USERNAME -p$PASSWORD $DATABASE;
 IFS=$OLDIFS
echo "$METADATA"
echo "$DATADIR"
