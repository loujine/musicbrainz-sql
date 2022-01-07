#!/bin/bash
set -eux

DBDATE="2022-01-07"
OUTPUTDIR="docs/${DBDATE}"

PGUSER="musicbrainz"
PGPW="musicbrainz"
# PGHOST="127.0.0.1"
# PGPORT=5432
DATABASE="musicbrainz_db"
PGPARAMS=$PGUSER:$PGPW@$PGHOST:$PGPORT/$DATABASE

INDEX="docs/index.md"

pushd queries
for script in *sql
do
    mkdir -p ../$OUTPUTDIR
    OUTPUTFILE="../$OUTPUTDIR/${script%.sql}.md"
    head -1 "$script" > "$OUTPUTFILE"
    sed -i 's/--/##/' "$OUTPUTFILE"
    echo "" >> "$OUTPUTFILE"
    psql postgres://"$PGPARAMS" -f "$script" >> "$OUTPUTFILE"
    sed -i 's/+--/|--/g' "$OUTPUTFILE"
    sed -i 's/--+/--|/g' "$OUTPUTFILE"
    sed -i '/^Time/d' "$OUTPUTFILE"
    sed -i 's/^\(([0-9]* rows\)/\n\1/' "$OUTPUTFILE"
done
popd

echo "" >> $INDEX
echo "## ${DBDATE}" >> $INDEX

pushd queries
for script in *sql
do
    echo " - [${script%.sql}](${DBDATE}/${script%.sql}.md)" >> ../$INDEX
done
popd

pushd ${OUTPUTDIR}
wc -l -- *md | sed -e 's/\ \ \ \ \ \ /000000/' | sed -e 's/\ \ \ \ \ /00000/' | sed -e 's/\ \ \ \ /0000/' | sed -e 's/\ \ \ /000/' | sort > ../${DBDATE}.counts
popd
