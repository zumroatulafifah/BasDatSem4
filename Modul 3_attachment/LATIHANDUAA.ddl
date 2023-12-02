CREATE TABLE jurusan (
    id_jurusan   INTEGER NOT NULL,
    nama_jurusan CHAR(50) NOT NULL,
    dosen        CHAR(50) NOT NULL
)
LOGGING;

ALTER TABLE jurusan ADD CONSTRAINT jurusan_pk PRIMARY KEY ( id_jurusan );

CREATE TABLE mahasiswa (
    id_mhs             INTEGER NOT NULL,
    nama_mhs           CHAR(100) NOT NULL,
    address            CHAR(50) NOT NULL,
    jurusan_id_jurusan INTEGER NOT NULL
)
LOGGING;

ALTER TABLE mahasiswa ADD CONSTRAINT mahasiswa_pk PRIMARY KEY ( id_mhs );

ALTER TABLE mahasiswa
    ADD CONSTRAINT mahasiswa_jurusan_fk FOREIGN KEY ( jurusan_id_jurusan )
        REFERENCES jurusan ( id_jurusan )
    NOT DEFERRABLE;