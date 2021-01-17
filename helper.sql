-- Helper functions


CREATE OR REPLACE
    FUNCTION to_artist_url(uuid) RETURNS text
    AS $$ SELECT text '<https://beta.musicbrainz.org/artist/' || $1 || '>' ; $$
    LANGUAGE SQL
    IMMUTABLE
;


CREATE OR REPLACE
    FUNCTION to_cdtoc_url(character) RETURNS text
    AS $$ SELECT text '<https://beta.musicbrainz.org/cdtoc/' || $1 || '>' ; $$
    LANGUAGE SQL
    IMMUTABLE
;


CREATE OR REPLACE
    FUNCTION to_label_url(uuid) RETURNS text
    AS $$ SELECT text '<https://beta.musicbrainz.org/label/' || $1 || '>' ; $$
    LANGUAGE SQL
    IMMUTABLE
;


CREATE OR REPLACE
    FUNCTION to_recording_url(uuid) RETURNS text
    AS $$ SELECT text '<https://beta.musicbrainz.org/recording/' || $1 || '>' ; $$
    LANGUAGE SQL
    IMMUTABLE
;


CREATE OR REPLACE
    FUNCTION to_release_url(uuid) RETURNS text
    AS $$ SELECT text '<https://beta.musicbrainz.org/release/' || $1 || '>' ; $$
    LANGUAGE SQL
    IMMUTABLE
;


CREATE OR REPLACE
    FUNCTION to_release_group_url(uuid) RETURNS text
    AS $$ SELECT text '<https://beta.musicbrainz.org/release-group/' || $1 || '>' ; $$
    LANGUAGE SQL
    IMMUTABLE
;


CREATE OR REPLACE
    FUNCTION to_track_url(uuid) RETURNS text
    AS $$ SELECT text '<https://beta.musicbrainz.org/track/' || $1 || '>' ; $$
    LANGUAGE SQL
    IMMUTABLE
;


CREATE OR REPLACE
    FUNCTION to_work_url(uuid) RETURNS text
    AS $$ SELECT text '<https://beta.musicbrainz.org/work/' || $1 || '>' ; $$
    LANGUAGE SQL
    IMMUTABLE
;


CREATE OR REPLACE
    FUNCTION to_md(text) RETURNS text
    AS $$ SELECT text '[' || $1 || '](' || $1 || ')' ; $$
    LANGUAGE SQL
    IMMUTABLE
    RETURNS NULL ON NULL INPUT
;


CREATE EXTENSION IF NOT EXISTS fuzzystrmatch;
