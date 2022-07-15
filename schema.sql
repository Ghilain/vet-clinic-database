/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

CREATE TABLE animals(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(110) NOT NULL,
    date_of_birth DATE,
    escapee_attempts INT,
    neutered BOOLEAN,
    weight_kg FLOAT
);


