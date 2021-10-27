-- Selection of classical artists

DROP TABLE IF EXISTS composer;
DROP TABLE IF EXISTS pianist;
DROP TABLE IF EXISTS violinist;
DROP TABLE IF EXISTS quartet;
DROP TABLE IF EXISTS conductor;


CREATE TABLE composer AS (
    SELECT
        id,
        gid,
        name,
        sort_name
    FROM
        artist
    WHERE
        sort_name IN (
            'Alkan, Charles-Valentin',
            'Bach, Johann Sebastian',
            'Bartók, Béla',
            'Beethoven, Ludwig van',
            'Berg, Alban',
            'Berlioz, Hector',
            'Boulez, Pierre',
            'Brahms, Johannes',
            'Bruckner, Anton',
            'Chausson, Ernest',
            'Chopin, Fryderyk',
            'Couperin, François',
            'Debussy, Claude',
            'Dowland, John',
            'Dukas, Paul',
            'Dvořák, Antonín',
            'Enescu, George',
            'Fauré, Gabriel',
            'Franck, César',
            'Glass, Philip',
            'Gounod, Charles-François',
            'Handel, George Frideric',
            'Haydn, Joseph',
            'Indy, Vincent d’',
            'Liszt, Franz',
            'Mahler, Gustav',
            'Mendelssohn, Felix',
            'Mozart, Wolfgang Amadeus',
            'Prokofiev, Sergei Sergeyevich',
            'Rachmaninoff, Sergei',
            'Rameau, Jean-Philippe',
            'Ravel, Maurice',
            'Schubert, Franz',
            'Schumann, Robert',
            'Scriabin, Alexander Nikolayevich',
            'Shostakovich, Dmitri Dmitrievich',
            'Sibelius, Jean',
            'Tchaikovsky, Pyotr Ilyich',
            'Vivaldi, Antonio',
            'Wagner, Richard',
            'Webern, Anton'
        )
    ORDER BY
        sort_name
);


CREATE TABLE pianist AS (
    SELECT
        id,
        gid,
        name,
        sort_name
    FROM
        artist
    WHERE
        name IN (
            'Alfred Brendel',
            'Alfred Cortot',
            'Andreas Staier',
            'András Schiff',
            'Annie Fischer',
            'Arthur Rubinstein',
            'Artur Schnabel',
            'Arturo Benedetti Michelangeli',
            'Bertrand Chamayou',
            'Blandine Rannou',
            'Blandine Verlet',
            'Christiane Jaccottet',
            'Christophe Rousset',
            'Claudio Arrau',
            'Cyprien Katsaris',
            'Cédric Pescia',
            'Cédric Tiberghien',
            'Daniel Barenboim',
            'Dino Ciani',
            'Dinu Lipatti',
            'Duo Egri & Pertis',
            'Duo Tal & Groethuysen',
            'Duo Uriarte-Mrongovius',
            'Edda Erlendsdóttir',
            'Edwin Fischer',
            'Frank Braley',
            'François Chaplin',
            'François Dumont',
            'François‐René Duchâble',
            'Friedrich Gulda',
            'Gerald Moore',
            'Glenn Gould',
            'Gustav Leonhardt',
            'Hélène Grimaud',
            'Jean-Efflam Bavouzet',
            'Jean-Frédéric Neuburger',
            'Jean-Marc Luisada',
            'Jean‐Bernard Pommier',
            'Jean‐François Heisser',
            'Jean‐Yves Thibaudet',
            'Jonathan Biss',
            'Jorge Bolet',
            'Leif Ove Andsnes',
            'Marc-André Hamelin',
            'Marie‐Josèphe Jude',
            'Martha Argerich',
            'Maurizio Pollini',
            'Michel Dalberto',
            'Nelson Freire',
            'Nicholas Angelich',
            'Nikita Magaloff',
            'Olivier Baumont',
            'Paul Badura-Skoda',
            'Philippe Cassard',
            'Pierre Barbizet',
            'Pierre-Laurent Aimard',
            'Rudolf Buchbinder',
            'Rudolf Serkin',
            'Samson François',
            'Trevor Pinnock',
            'Vladimir Ashkenazy',
            'Víkingur Ólafsson',
            'Walter Gieseking',
            'Wilhelm Backhaus',
            'Wilhelm Kempff',
            'Yves Nat',
            'Éric Heidsieck',
            'Владимир Самойлович Горовиц',
            'Генрих Густавович Нейгауз',
            'Мария Юдина',
            'Святослав Теофилович Рихтер',
            'Татьяна Пeтрoвнa Николаева',
            'Эмиль Григорьевич Гилельс'
        )
    ORDER BY
        sort_name
);


CREATE TABLE conductor AS (
    SELECT
        id,
        gid,
        name,
        sort_name
    FROM
        artist
    WHERE
        name IN (
            'André Cluytens',
            'Arturo Toscanini',
            'Carlo Maria Giulini',
            'Carlos Kleiber',
            'Claudio Abbado',
            'Eugen Jochum',
            'Felix Weingartner',
            'Franz Konwitschny',
            'Hans Knappertsbusch',
            'Jean Martinon',
            'Karl Böhm',
            'Lorin Maazel',
            'Nikolaus Harnoncourt',
            'Otto Klemperer',
            'Pierre Boulez',
            'Riccardo Muti',
            'Sergiu Celibidache',
            'Simon Rattle',
            'Wilhelm Furtwängler'
        )
    ORDER BY
        sort_name
);


CREATE TABLE quartet AS (
    SELECT
        id,
        gid,
        name,
        sort_name
    FROM
        artist
    WHERE
        name IN (
            'Alban Berg Quartett',
            'Amadeus Quartet',
            'Beethoven String Quartet',
            'Belcea Quartet',
            'Borodin Quartet',
            'Budapest String Quartet',
            'Busch Quartet',
            'Emerson String Quartet',
            'Eþos kvartettinn',
            'Fine Arts Quartet',
            'Guarneri Quartet',
            'Hagen Quartett',
            'Hungarian Quartet',
            'Juilliard String Quartet',
            'LaSalle Quartet',
            'Lindsay String Quartet',
            'Loewenguth Quartet',
            'Melos Quartett',
            'Quartetto Italiano',
            'Quatuor Diotima',
            'Quatuor Debussy',
            'Quatuor Ébène',
            'Quatuor Hermès',
            'Quatuor Mosaïques',
            'Skálholt Quartet',
            'Smetana Quartet',
            'Takács Quartet',
            'Talichovo kvarteto',
            'Tokyo String Quartet',
            'Végh Quartet'
        )
    ORDER BY
        sort_name
);


CREATE TABLE violinist AS (
    SELECT
        id,
        gid,
        name,
        sort_name
    FROM
        artist
    WHERE
        sort_name IN (
            'Ferras, Christian',
            'Menuhin, Yehudi',
            'Milstein, Nathan',
            'Oistrakh, David Fiodorovich',
            'Szigeti, Joseph'
        )
    ORDER BY
        sort_name
);


-- CREATE TABLE singer AS
-- CREATE TABLE opera_singer AS
