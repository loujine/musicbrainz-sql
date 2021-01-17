Musicbrainz SQL reports
=======================

Collection of SQL queries I wrote for exploring the
[MusicBrainz](https://musicbrainz.org) database. They are analogous to
[reports](https://musicbrainz.org/reports) that can be run on the production
database.

A static version of the reports is available on
<https://loujine.github.io/musicbrainz-sql/>.


I run these scripts on a local copy of the Musicbrainz database. You can install
one by installing [mbdata](https://pypi.org/project/mbdata/) or using the
official [docker](https://github.com/metabrainz/musicbrainz-docker/) solution.


Some of the queries need two scripts to populate the database before they can be
run:

 * helper.sql: create helper functions, e.g. to generate musicbrainz urls from
 entities UUID, added for improving the queries readibility;
 * create_artist_selection.sql: create artist tables for a selection of
 classical composers/conductors/etc., corresponding to artist collections I am
 following.
