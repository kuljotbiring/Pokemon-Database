-- Author:          Sandro Aguilar and Kuljot Biring
-- Class:           CS 340
-- Description:     DML SQL file: data manipulation


-- SELECT QUERY                 --------------------------------------------------------------------
-- for / home page to show current pokemon in database (updated)
SELECT Pokemon.pokemonID, Names.name, Names.imageURL, Types.name, Abilities.abilityName, Ratings.rating, Gyms.location,Ratings.ratingID, Gyms.gymID 
FROM Pokemon
INNER JOIN Ratings ON Pokemon.ratingID = Ratings.ratingID
INNER JOIN Names ON Pokemon.NameID = Names.NameID
INNER JOIN Gyms ON Pokemon.gymID = Gyms.gymID
INNER JOIN PokemonAbilities ON Pokemon.pokemonID = PokemonAbilities.pokemonID
INNER JOIN PokemonTypes ON Pokemon.pokemonID = PokemonTypes.pokemonID
INNER JOIN Abilities ON PokemonAbilities.abilityID = Abilities.abilityID
INNER JOIN Types ON Types.typeID = PokemonTypes.typeID
ORDER BY Pokemon.pokemonID ASC

--  for /home page to READ from various tables to obtain the data needed to display data
SELECT name FROM Names
SELECT * FROM Types
SELECT * FROM Abilities
SELECT * FROM Ratings
SELECT * FROM Gyms

-- for the /search page to show pokemon search results
-- this query searches for the search terms entered in the search bar (:search_term) and the
-- where clause depends on the type of search requested and the :modifier is also used to
-- work with the type of search requested
SELECT Pokemon.pokemonID, Names.name, Names.imageURL, Types.name, Abilities.abilityName, Ratings.rating, Gyms.location,Ratings.ratingID, Gyms.gymID
FROM Pokemon
INNER JOIN Ratings ON Pokemon.ratingID = Ratings.ratingID
INNER JOIN Names ON Pokemon.NameID = Names.NameID
INNER JOIN Gyms ON Pokemon.gymID = Gyms.gymID
INNER JOIN PokemonAbilities ON Pokemon.pokemonID = PokemonAbilities.pokemonID
INNER JOIN PokemonTypes ON Pokemon.pokemonID = PokemonTypes.pokemonID
INNER JOIN Abilities ON PokemonAbilities.abilityID = Abilities.abilityID
INNER JOIN Types ON Types.typeID = PokemonTypes.typeID
WHERE :where_clause :modifier LIKE $:search_term$ OR $:search_term$


-- INSERT QUERIES
-- for /home page to add a new pokemo. This query was updated to first grab the necessary ID's
-- from other tables and then uses those IDs to insert into the Pokemon table. Then another
-- series of queries are made to insert data into any other required tables (intersection tables)
SELECT nameID FROM Names WHERE name = ':pokemon'
SELECT Names.imageURL FROM Names WHERE name = ':pokemon'
SELECT abilityID FROM Abilities WHERE abilityName = ':abilities'
SELECT typeID FROM Types WHERE name = 'pokeType'
SELECT gymID FROM Gyms WHERE gymName = 'gym'
SELECT ratingID FROM Ratings WHERE rating = 'rating'
INSERT INTO Pokemon (nameID, gymID, ratingID) VALUES (:nameID, :image_url, :gymID, :ratingID)
INSERT INTO PokemonAbilities (pokemonID, abilityID) VALUES (:pokemonID, :abilityID)
INSERT INTO PokemonTypes (pokemonID, typeID) VALUES (:pokemonID, :typeID)


-- Queries for the Admin Panel page (/admin-menu)
-- /create-pokemon
-- /add/add-type-rel
-- /add-ability-rel
-- /add-gym
-- /add-rating
-- /add-abilities
-- /add-type)
INSERT INTO Names (name, imageURL) VALUES (:pokemonName, :imageURL)
INSERT INTO Gyms (gymName, location) VALUES (:new_name:, :new_location:);
INSERT INTO Ratings (rating) VALUES (:new_rating:);
INSERT INTO Abilities (abilityName) VALUES (:new_ability:);
INSERT INTO Types (name) VALUES (:new_type:);


-- UPDATE QUERIES
-- work in progress
-- for / home page to edit a pokemon
-- this updates Pokemon and its corresponding intersection tables
-- also shows how other tables will be updated
-- variables are denoted as :variable:
UPDATE Pokemon
SET name = :nameID: = :new_name_id:
WHERE pokemonID = :pokemon_id_selected:

UPDATE PokemonAbilities
SET abilityID = :new_ability_id:
WHERE pokemonID = :pokemonID:

UPDATE PokemonTypes
SET typeID = :new_type_id:
WHERE pokemonID = :pokemonID:

UPDATE Gyms
SET gymName = :new_name:, location = :new_location:
WHERE gymID = :gymID_to_update:

UPDATE Ratings
SET rating = :new_rating:
WHERE ratingID = :rating_to_update:

UPDATE Abilities
SET abilityName = :new_ability:
WHERE abilityID = :ability_to_update:

UPDATE Types
SET name = :new_type:
WHERE typeID = :type_to_update:


-- DELETE QUERY
-- work in progress
-- for / home page to delete a pokemon
-- this deletes Pokemon and its corresponding intersection tables
-- also shows examples of deleting from other tables
-- variables are denoted as :variable:
DELETE FROM Pokemon
WHERE pokemonID = :pokemon_to_delete:

DELETE FROM Gyms
WHERE GymID = :gym_to_delete:

DELETE FROM Ratings
WHERE ratingID = :rating_to_delete:

DELETE FROM Abilities
WHERE abilityID = :ability_to_delete:

DELETE FROM Types
WHERE typeID = :type_to_delete:

DELETE FROM PokemonAbilities
WHERE abilityID = :ability_to_delete:

DELETE FROM PokemonTypes
WHERE typeID = :type_to_delete:
