/* Populate database with sample data. */

-- Insert data in animals table
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escapee_attempts) VALUES ('Agumon', '2020-02-03', 10.23, true, 0);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escapee_attempts) VALUES ('Gabumon', '2018-11-15', 8, true, 2);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escapee_attempts) VALUES ('Pikachu', '2021-01-07', 15.04, false, 1);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escapee_attempts) VALUES ('Devimon', '2017-05-12', 11, true, 5);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escapee_attempts) VALUES ('Charmander', '2020-02-08', -11, false, 0);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escapee_attempts) VALUES ('Plantmon', '2021-11-15', -5.7, true, 2);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escapee_attempts) VALUES ('Squirtle', '1993-04-02', -12.13, false, 3);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escapee_attempts) VALUES ('Angemon', '2005-06-12', -45, true, 1);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escapee_attempts) VALUES ('Boarmon', '2005-06-07', 20.4, true, 7);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escapee_attempts) VALUES ('Blossom', '1998-10-13', 17, true, 3);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escapee_attempts) VALUES ('Ditto', '2022-05-14', 22, true, 4);

-- Insert data in table owners
INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age) VALUES ('Bob', 45);
INSERT INTO owners (full_name, age) VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', 38);

-- Insert data in table species
INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');

-- modify animals table and set value to species_id
BEGIN;
UPDATE animals SET species_id=(SELECT id FROM species WHERE name='Digimon') WHERE name LIKE '%mon';
UPDATE animals SET species_id=(SELECT id FROM species WHERE name='Pokemon') WHERE species_id IS NULL;
COMMIT;

-- modify animals table and set value to owner_id
BEGIN;
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE  full_name = 'Sam Smith') WHERE name = 'Agumon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE  full_name = 'Jennifer Orwell') WHERE name = 'Gabumon' OR name = 'Pikachu';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE  full_name = 'Bob') WHERE name = 'Devimon' OR name = 'Plantmon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE  full_name = 'Melody Pond') WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE  full_name = 'Dean Winchester') WHERE name = 'Angemon' OR name ='Boarmon';
COMMIT;

-- insert data in vets table

INSERT INTO vets (name, age, date_of_graduation) VALUES ('William Tatcher', 45, '2000-4-23');

INSERT INTO vets (name, age, date_of_graduation) VALUES ('Maisy Smith', 26, '2019-1-17');

INSERT INTO vets (name, age, date_of_graduation) VALUES ('Stephanie Mendez', 64, '1981-5-4');

INSERT INTO vets (name, age, date_of_graduation) VALUES ('Jack Harkness', 38, '2008-6-8');


-- insert data in specializations table
 INSERT INTO specializations (vets_id,species_id) VALUES 
 ((SELECT id FROM vets WHERE name='William Tatcher'), (SELECT id FROM species WHERE name='Pokemon'));


INSERT INTO specializations (vets_id,species_id) VALUES 
((SELECT id FROM vets WHERE name='Stephanie Mendez'), (SELECT id FROM species WHERE name='Pokemon'));


INSERT INTO specializations (vets_id,species_id) VALUES 
((SELECT id FROM vets WHERE name='Stephanie Mendez'), (SELECT id FROM species WHERE name='Digimon'));


INSERT INTO specializations (vets_id,species_id) VALUES 
((SELECT id FROM vets WHERE name='Jack Harkness'), (SELECT id FROM species WHERE name='Digimon'));


-- insert data in visits table


INSERT INTO visits (vets_id, animal_id, visited_date) VALUES ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Angemon'), '2020-10-03');

INSERT INTO visits (vets_id, animal_id, visited_date) VALUES ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Angemon'), '2020-11-4');

INSERT INTO visits (vets_id, animal_id, visited_date) VALUES ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), '2019-01-24');

INSERT INTO visits (vets_id, animal_id, visited_date) VALUES ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), '2019-05-15');

INSERT INTO visits (vets_id, animal_id, visited_date) VALUES ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), '2020-02-27');

INSERT INTO visits (vets_id, animal_id, visited_date) VALUES((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), '2020-10-03');

INSERT INTO visits (vets_id, animal_id, visited_date) VALUES ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name = 'Blossom'), '2020-05-24');

INSERT INTO visits (vets_id, animal_id, visited_date) VALUES ((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM animals WHERE name = 'Blossom'), '2021-11-01');

