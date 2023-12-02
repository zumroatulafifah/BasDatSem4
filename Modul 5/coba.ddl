CREATE TABLE barang (
    kode                   INTEGER NOT NULL,
    nama                   VARCHAR2(50) NOT NULL,
    warna                  VARCHAR2(50) NOT NULL,
    harga_jual             INTEGER,
    harga_beli             INTEGER,
    supplier_id            INTEGER,
    pelanggan_pelanggan_id INTEGER,
    kategori_kode          INTEGER
)
LOGGING;

ALTER TABLE barang ADD CONSTRAINT barang_pk PRIMARY KEY ( kode );

CREATE TABLE kategori (
    kode          INTEGER NOT NULL,
    nama_kategori VARCHAR2(50) NOT NULL
)
LOGGING;

ALTER TABLE kategori ADD CONSTRAINT kategori_pk PRIMARY KEY ( kode );

CREATE TABLE pegawai (
    id           INTEGER NOT NULL,
    nama_pegawai VARCHAR2(100) NOT NULL,
    department   VARCHAR2(100) NOT NULL,
    pelanggan_id VARCHAR2(100)
)
LOGGING;

ALTER TABLE pegawai ADD CONSTRAINT pegawai_pk PRIMARY KEY ( id );

CREATE TABLE pelanggan (
    pelanggan_id   INTEGER NOT NULL,
    nama_pelanggan VARCHAR2(100) NOT NULL,
    city           VARCHAR2(100) NOT NULL,
    pegawai_id     INTEGER
)
LOGGING;

ALTER TABLE pelanggan ADD CONSTRAINT pelanggan_pk PRIMARY KEY ( pelanggan_id );

CREATE TABLE pembayaran (
    pemesanan_no_pesanan INTEGER,
    id_pembayaran        INTEGER NOT NULL,
    total                INTEGER NOT NULL
)
LOGGING;

CREATE UNIQUE INDEX pembayaran__idx ON
    pembayaran (
        pemesanan_no_pesanan
    ASC )
        LOGGING;

ALTER TABLE pembayaran ADD CONSTRAINT pembayaran_pk PRIMARY KEY ( id_pembayaran );

CREATE TABLE pemesanan (
    no_pesanan               INTEGER NOT NULL,
    nama_pesanan             VARCHAR2(100) NOT NULL,
    total_harga              INTEGER NOT NULL,
    barang_kode              INTEGER,
    pembayaran_id_pembayaran INTEGER,
    pelanggan_pelanggan_id   INTEGER
)
LOGGING;

CREATE UNIQUE INDEX pemesanan__idx ON
    pemesanan (
        pembayaran_id_pembayaran
    ASC )
        LOGGING;

ALTER TABLE pemesanan ADD CONSTRAINT pemesanan_pk PRIMARY KEY ( no_pesanan );

CREATE TABLE pengiriman (
    nomor_kirim          INTEGER NOT NULL,
    nama_penerima        VARCHAR2(50) NOT NULL,
    telepon_penerima     INTEGER NOT NULL,
    pegawai_id           INTEGER,
    pemesanan_no_pesanan INTEGER,
    tgl_kirim            DATE,
    keterangan_kirim     VARCHAR2(50)
)
LOGGING;

ALTER TABLE pengiriman ADD CONSTRAINT pengiriman_pk PRIMARY KEY ( nomor_kirim );

CREATE TABLE supplier (
    id              INTEGER NOT NULL,
    nama            VARCHAR2(50) NOT NULL,
    telepon         INTEGER NOT NULL,
    alamat_supplier CHAR(50) NOT NULL
)
LOGGING;

ALTER TABLE supplier ADD CONSTRAINT supplier_pk PRIMARY KEY ( id );

ALTER TABLE barang
    ADD CONSTRAINT barang_kategori_fk FOREIGN KEY ( kategori_kode )
        REFERENCES kategori ( kode )
    NOT DEFERRABLE;

ALTER TABLE barang
    ADD CONSTRAINT barang_pelanggan_fk FOREIGN KEY ( pelanggan_pelanggan_id )
        REFERENCES pelanggan ( pelanggan_id )
    NOT DEFERRABLE;

ALTER TABLE barang
    ADD CONSTRAINT barang_supplier_fk FOREIGN KEY ( supplier_id )
        REFERENCES supplier ( id )
    NOT DEFERRABLE;

ALTER TABLE pelanggan
    ADD CONSTRAINT pelanggan_pegawai_fk FOREIGN KEY ( pegawai_id )
        REFERENCES pegawai ( id )
    NOT DEFERRABLE;

ALTER TABLE pemesanan
    ADD CONSTRAINT pemesanan_barang_fk FOREIGN KEY ( barang_kode )
        REFERENCES barang ( kode )
    NOT DEFERRABLE;

ALTER TABLE pemesanan
    ADD CONSTRAINT pemesanan_pelanggan_fk FOREIGN KEY ( pelanggan_pelanggan_id )
        REFERENCES pelanggan ( pelanggan_id )
    NOT DEFERRABLE;

ALTER TABLE pengiriman
    ADD CONSTRAINT pengiriman_pegawai_fk FOREIGN KEY ( pegawai_id )
        REFERENCES pegawai ( id )
    NOT DEFERRABLE;

ALTER TABLE pengiriman
    ADD CONSTRAINT pengiriman_pemesanan_fk FOREIGN KEY ( pemesanan_no_pesanan )
        REFERENCES pemesanan ( no_pesanan )
    NOT DEFERRABLE;