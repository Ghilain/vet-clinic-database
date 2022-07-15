/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered=true AND escapee_attempts<=3;
SELECT date_of_birth FROM animals WHERE name='Agumon' OR name='Pikachu';
SELECT name, escapee_attempts FROM animals WHERE weight_kg>10.5;
SELECT * FROM animals WHERE neutered=true;
SELECT * FROM animals WHERE name!='Gabumon';
SELECT * FROM animals WHERE weight_kg>=10.4 AND weight_kg<=17.3;

-- Update species and roll back
BEGIN;
UPDATE animals SET species= 'unspecified';
SELECT species FROM animals;
ROLLBACK;

-- update species and commit
BEGIN;
UPDATE animals SET species='digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT species FROM animals;
COMMIT;
SELECT * FROM animals;

-- delete table and roll back
BEGIN;
DROP TABLE animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Inside a transaction
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT  to_be_update;
UPDATE animals SET weight_kg=weight_kg*-1;
ROLLBACK TO to_be_update;
UPDATE animals SET weight_kg=weight_kg*-1 WHERE weight_kg < 0;
COMMIT;

-- How many animals are there?
SELECT COUNT(*) FROM animals;
-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE  escapee_attempts = 0;
-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;
-- Who escapes the most, neutered or not neutered animals?
SELECT COUNT(escapee_attempts) AS most_escaped,neutered FROM animals GROUP BY neutered;
-- What is the minimum and maximum weight of each type of animal?
 SELECT MAX(weight_kg) AS max_weight, MIN(weight_kg) AS min_weight FROM animals;
-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT neutered, AVG(escapee_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY neutered;
