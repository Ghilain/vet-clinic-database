/* Database schema to keep the structure of entire database. */

-- create database vet_clinic
CREATE DATABASE vet_clinic;

-- create table animals
CREATE TABLE animals(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(110) NOT NULL,
    date_of_birth DATE,
    escapee_attempts INT,
    neutered BOOLEAN,
    weight_kg FLOAT
);

/* add new column*/

ALTER TABLE animals ADD species VARCHAR(200);

-- create table owners
CREATE TABLE owners(
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(110) NOT NULL,
    age INT
);

-- create table species
CREATE TABLE species(
    id SERIAL PRIMARY KEY,
    name VARCHAR(110) NOT NULL
);

/* remove columns species in animals*/

ALTER TABLE animals DROP species;

/* add new columns in animals*/
ALTER TABLE animals ADD species_id INT, ADD FOREIGN KEY (species_id) REFERENCES species(id) ON DELETE CASCADE;
ALTER TABLE animals ADD owner_id INT, ADD FOREIGN KEY (owner_id) REFERENCES owners(id) ON DELETE CASCADE;
