#!/bin/sh
set -eux

DBDATE="2021-01-13"
OUTPUTDIR="docs/${DBDATE}/"

PGUSER="musicbrainz"
PGPW="musicbrainz"
PGHOST="192.168.1.8"
PGPORT=5432
DATABASE="musicbrainz_db"
PGPARAMS=$PGUSER:$PGPW@$PGHOST:$PGPORT/$DATABASE

INDEX="docs/index.md"

for script in [^hc]*sql
do
    mkdir -p $OUTPUTDIR
    psql postgres://$PGPARAMS -f $script > docs/$DBDATE/${script%.sql}.md
    sed -i 's/+/|/g' $OUTPUTDIR/${script%.sql}.md
    sed -i '/^Time/d' $OUTPUTDIR/${script%.sql}.md
    sed -i 's/^\(([0-9]* rows\)/\n\1/' $OUTPUTDIR/${script%.sql}.md
done

echo "" >> $INDEX
echo "## ${DBDATE}" >> $INDEX
for script in [^hc]*sql
do
    echo " - [${script%.sql}](${DBDATE}/${script%.sql}.md)" >> $INDEX
done

