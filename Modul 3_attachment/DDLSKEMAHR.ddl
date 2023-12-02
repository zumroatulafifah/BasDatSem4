CREATE TABLE countries (
    country_id        INTEGER NOT NULL,
    country_name      VARCHAR2(50) NOT NULL,
    region_id         INTEGER NOT NULL,
    regions_region_id INTEGER NOT NULL
)
LOGGING;

ALTER TABLE countries ADD CONSTRAINT countries_pk PRIMARY KEY ( country_id );

CREATE TABLE departements (
    departement_id        INTEGER NOT NULL,
    departement_name      VARCHAR2(50) NOT NULL,
    manager_id            INTEGER NOT NULL,
    location_id           INTEGER NOT NULL,
    locations_location_id INTEGER NOT NULL
)
LOGGING;

ALTER TABLE departements ADD CONSTRAINT departements_pk PRIMARY KEY ( departement_id );

CREATE TABLE employees (
    employee_id                  INTEGER NOT NULL,
    first_name                   VARCHAR2(50) NOT NULL,
    last_name                    VARCHAR2(50) NOT NULL,
    email                        VARCHAR2(50) NOT NULL,
    phone_number                 INTEGER NOT NULL,
    hire_date                    DATE NOT NULL,
    job_id                       INTEGER NOT NULL,
    salary                       INTEGER NOT NULL,
    commission_pct               INTEGER NOT NULL,
    manager_id                   INTEGER NOT NULL,
    departement_id               INTEGER NOT NULL,
    departements_departement_id2 INTEGER NOT NULL,
    employees_employee_id        INTEGER NOT NULL,
    departements_departement_id  INTEGER NOT NULL,
    jobs_job_id                  INTEGER NOT NULL
)
LOGGING;

CREATE UNIQUE INDEX employees__idx ON
    employees (
        departements_departement_id2
    ASC )
        LOGGING;

ALTER TABLE employees ADD CONSTRAINT employees_pk PRIMARY KEY ( employee_id );

CREATE TABLE job_history (
    employee_id                 INTEGER NOT NULL,
    start_date                  DATE NOT NULL,
    end_date                    DATE NOT NULL,
    job_id                      INTEGER NOT NULL,
    departement_id              INTEGER NOT NULL,
    departements_departement_id INTEGER NOT NULL,
    jobs_job_id                 INTEGER NOT NULL,
    employees_employee_id       INTEGER NOT NULL
)
LOGGING;

ALTER TABLE job_history ADD CONSTRAINT job_history_pk PRIMARY KEY ( employee_id,
                                                                    start_date );

CREATE TABLE jobs (
    job_id     INTEGER NOT NULL,
    job_title  VARCHAR2(50) NOT NULL,
    min_salary INTEGER NOT NULL,
    max_salary INTEGER NOT NULL
)
LOGGING;

ALTER TABLE jobs ADD CONSTRAINT jobs_pk PRIMARY KEY ( job_id );

CREATE TABLE locations (
    location_id          INTEGER NOT NULL,
    street_address       VARCHAR2(50) NOT NULL,
    postal_code          INTEGER NOT NULL,
    city                 VARCHAR2(50) NOT NULL,
    state_province       VARCHAR2(50) NOT NULL,
    country_id           INTEGER NOT NULL,
    countries_country_id INTEGER NOT NULL
)
LOGGING;

ALTER TABLE locations ADD CONSTRAINT locations_pk PRIMARY KEY ( location_id );

CREATE TABLE regions (
    region_id   INTEGER NOT NULL,
    region_name VARCHAR2(50) NOT NULL
)
LOGGING;

ALTER TABLE regions ADD CONSTRAINT regions_pk PRIMARY KEY ( region_id );

ALTER TABLE countries
    ADD CONSTRAINT countries_regions_fk FOREIGN KEY ( regions_region_id )
        REFERENCES regions ( region_id )
    NOT DEFERRABLE;

ALTER TABLE departements
    ADD CONSTRAINT departements_locations_fk FOREIGN KEY ( locations_location_id )
        REFERENCES locations ( location_id )
    NOT DEFERRABLE;

ALTER TABLE employees
    ADD CONSTRAINT employees_departements_fk FOREIGN KEY ( departements_departement_id )
        REFERENCES departements ( departement_id )
    NOT DEFERRABLE;

ALTER TABLE employees
    ADD CONSTRAINT employees_departements_fkv2 FOREIGN KEY ( departements_departement_id2 )
        REFERENCES departements ( departement_id )
    NOT DEFERRABLE;

ALTER TABLE employees
    ADD CONSTRAINT employees_employees_fk FOREIGN KEY ( employees_employee_id )
        REFERENCES employees ( employee_id )
    NOT DEFERRABLE;

ALTER TABLE employees
    ADD CONSTRAINT employees_jobs_fk FOREIGN KEY ( jobs_job_id )
        REFERENCES jobs ( job_id )
    NOT DEFERRABLE;

ALTER TABLE job_history
    ADD CONSTRAINT job_history_departements_fk FOREIGN KEY ( departements_departement_id )
        REFERENCES departements ( departement_id )
    NOT DEFERRABLE;

ALTER TABLE job_history
    ADD CONSTRAINT job_history_employees_fk FOREIGN KEY ( employees_employee_id )
        REFERENCES employees ( employee_id )
    NOT DEFERRABLE;

ALTER TABLE job_history
    ADD CONSTRAINT job_history_jobs_fk FOREIGN KEY ( jobs_job_id )
        REFERENCES jobs ( job_id )
    NOT DEFERRABLE;

ALTER TABLE locations
    ADD CONSTRAINT locations_countries_fk FOREIGN KEY ( countries_country_id )
        REFERENCES countries ( country_id )
    NOT DEFERRABLE;