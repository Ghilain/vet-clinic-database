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


-- Write queries (using JOIN) to answer the following questions:
-- What animals belong to Melody Pond?
SELECT name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name='Melody Pond';
-- List of all animals that are pokemon (their type is Pokemon).
SELECT * FROM animals JOIN species ON animals.species_id = species.id where species.name='Pokemon';
-- List all owners and their animals, remember to include those that don't own any animal.
SELECT full_name, name FROM owners LEFT OUTER JOIN animals ON owners.id = animals.owner_id;
-- How many animals are there per species?
SELECT species.name, COUNT(*) FROM species JOIN animals ON animals.species_id = species.id GROUP BY species.name;
-- List all Digimon owned by Jennifer Orwell.
SELECT owners.full_name AS Owner_Full_name, animals.* FROM animals JOIN owners ON animals.owner_id= owners.id JOIN species ON animals.species_id=species.id WHERE owners.full_name='Jennifer Orwell' AND species.name='Digimon';
-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT owners.full_name AS Owner_Full_name, animals.* FROM animals JOIN owners ON animals.owner_id= owners.id WHERE owners.full_name='Dean Winchester' AND animals.escapee_attempts=0;
-- Who owns the most animals?
SELECT owners.full_name, COUNT(animals.*) FROM owners JOIN animals ON animals.owner_id = owners.id GROUP BY owners.full_name ORDER BY COUNT DESC LIMIT 1;


-- Write queries to answer the following:
-- Who was the last animal seen by William Tatcher?
SELECT animals.name FROM animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vets_id WHERE vets.name = 'William Tatcher' ORDER BY visits.visited_date DESC LIMIT 1;
-- How many different animals did Stephanie Mendez see?
SELECT COUNT(animals.*) FROM animals JOIN visits ON visits.animal_id = animals.id JOIN vets ON vets.id = visits.vets_id WHERE vets.name = 'Stephanie Mendez';
-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name AS VET_NAME, species.name AS SPE_NAME FROM vets LEFT JOIN specializations ON specializations.vets_id = vets.id LEFT JOIN species ON species.id = specializations.species_id;
-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name, visits.visited_date FROM animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vets_id WHERE vets.name = 'Stephanie Mendez' AND visits.visited_date BETWEEN '2020-4-1' AND '2020-8-30';
-- What animal has the most visits to vets?
SELECT animals.name, COUNT(visits.*) FROM animals JOIN visits ON animals.id = visits.animal_id GROUP BY animals.name ORDER BY COUNT DESC LIMIT 1;
-- Who was Maisy Smith's first visit?
SELECT  animals.name FROM animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vets_id WHERE vets.name = 'Maisy Smith' ORDER BY visits.visited_date ASC LIMIT 1;
-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.*, vets.name as VET_NAME, vets.age as vet_age, vets.date_of_graduation, visits.visited_date FROM animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vets_id ORDER BY visits.visited_date DESC LIMIT 1;
-- How many visits were with a vet that did not specialize in that animal's species?
SELECT DISTINCT COUNT(visits.*) FROM visits JOIN vets ON vets.id = visits.vets_id LEFT JOIN specializations ON specializations.vets_id = vets.id WHERE specializations.vets_id IS NULL;
-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT DISTINCT species.name, COUNT(visits.*) FROM visits JOIN animals ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vets_id JOIN species ON species.id = animals.species_id LEFT JOIN specializations ON specializations.vets_id = vets.id  WHERE specializations.vets_id IS NULL AND vets.name = 'Maisy Smith' GROUP BY species.name ORDER BY COUNT DESC limit 1;
