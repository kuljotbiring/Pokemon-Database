-- Author:          Sandro Aguilar and Kuljot Biring
-- Class:           CS 340
-- Description:     DDL SQL File: Create and Seed Database


-- -------------------------------------------------------------------------
-- a) DDL Queries
-- -------------------------------------------------------------------------

-- Drop prior tables and reset this database
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS PokemonAbilities;
DROP TABLE IF EXISTS PokemonTypes;
DROP TABLE IF EXISTS Pokemon;
DROP TABLE IF EXISTS Gyms;
DROP TABLE IF EXISTS Ratings;
DROP TABLE IF EXISTS Abilities;
DROP TABLE IF EXISTS Types;
SET FOREIGN_KEY_CHECKS = 1;


-- Create Tables Instructions
CREATE TABLE Gyms (
  gymID int(11) NOT NULL AUTO_INCREMENT,
  gymName varchar(255) DEFAULT NULL,
  location varchar(255) DEFAULT NULL,
  PRIMARY KEY (gymID)
);

CREATE TABLE Ratings (
  ratingID int(11) NOT NULL AUTO_INCREMENT,
  rating varchar(255) NOT NULL,
  PRIMARY KEY (ratingID)
);

CREATE TABLE Abilities (
  abilityID int(11) NOT NULL AUTO_INCREMENT,
  abilityName varchar(255) NOT NULL,
  PRIMARY KEY (abilityID)
);

CREATE TABLE Types (
  typeID int(11) NOT NULL AUTO_INCREMENT,
  name varchar(255) NOT NULL,
  PRIMARY KEY (typeID)
);

CREATE TABLE Pokemon (
  pokemonID int(11) NOT NULL AUTO_INCREMENT,
  name varchar(255) NOT NULL,
  url varchar(255) NOT NULL,
  gymID int(11),
  ratingID int(11),
  FOREIGN KEY(gymID) REFERENCES Gyms(gymID) ON DELETE SET NULL ON UPDATE CASCADE,
  FOREIGN KEY(ratingID) REFERENCES Ratings(ratingID) ON DELETE SET NULL ON UPDATE CASCADE,
  PRIMARY KEY (pokemonID)
);

-- Intersection M:M table to connect Abilities to Pokemon
CREATE TABLE PokemonAbilities (
  pokemonID int(11),
  abilityID int(11),
  FOREIGN KEY (pokemonID) REFERENCES Pokemon (pokemonID),
  FOREIGN KEY (abilityID) REFERENCES Abilities (abilityID)
);

-- Intersection M:M table to connect Types to Pokemon
CREATE TABLE PokemonTypes (
  pokemonID int(11),
  typeID int(11),
  FOREIGN KEY (pokemonID) REFERENCES Pokemon (pokemonID),
  FOREIGN KEY (typeID) REFERENCES Types (typeID)
);


-- -------------------------------------------------------------------------
-- b) SAMPLE DATA
-- Seed Database Instructions
-- -------------------------------------------------------------------------
INSERT INTO Gyms (gymName, location)
VALUES
(NULL, NULL),
('Pewter City Gym', 'Pewter City'),
('Cerulean Gym', 'Cerulean City'),
('Vermillion Gym', 'Vermillion City'),
('Celadon Gym', 'Celadon City'),
('Fuchsia City Gym', 'Fuchsia City'),
('Saffron City Gym', 'Saffron City'),
('Cinnabar Island Gym', 'Cinnabar Island City'),
('Viridian City Gym', 'Viridian City');

INSERT INTO Ratings (rating)
VALUES
('Bad'),
('Poor'),
('Fair'),
('Good'),
('Excellent');

INSERT INTO Abilities (abilityName)
VALUES
('Overgrow, Chlorophyll'), ('Blaze, Solar Power'), ('Torrent, Rain Dish'), ('Shield Dust, Run Away'), ('Shed Skin'), ('Compoundeyes, Tinted Lens'), ('Shield Dust, Run Away'), ('Poison'), ('Swarm, Sniper'), ('Keen Eye, Tangled Feet, Big Pecks'), ('Rattata, Guts, Hustle'), ('Run Away, Guts, Hustle'), ('Keen Eye, Sniper'), ('Intimidate, Shed Skin, Unnerve'), ('Static, Lightning Rod'), ('Sand Veil, Sand Rush'), ('Poison Point, Rivalry, Hustle'), ('Poison Point, Rivalry, Sheer Force'), ('Poison Point, Rivalry, Hustle'), ('Poison Point, Rivalry, Sheer Force'), ('Cute Charm, Magic Guard, Friend Guard'), ('Cute Charm, Magic Guard, Unaware'), ('Flash Fire, Drought'), ('Cute Charm, Competitive, Friend Guard'), ('Cute Charm, Competitive, Frisk'), ('Inner Focus, Infiltrator'), ('Chlorophyll, Run Away'), ('Chlorophyll, Stench'), ('Chlorophyll, Effect Spore'), ('Effect Spore, Dry Skin,Damp'), ('Compoundeyes, Tinted Lens, Run Away'), ('Shield Dust, Tinted Lens, Wonder Skin'), ('Sand Veil, Arena Trap, Sand Force'), ('Pickup, Technician, Unnerve'), ('Limber, Technician, Unnerve'), ('Damp, Cloud Nine, Swift Swim'), ('Vital Spirit, Anger Point, Defiant'), ('Intimidate, Flash Fire, Justified'), ('Water Absorb, Damp, Swift Swim'), ('Synchronize, Inner Focus, Magic Guard'), ('Guts, No Guard, Steadfast'), ('Poison, Chlorophyll, Gluttony'), ('Clear Body, Liquid Ooze, Rain Dish'), ('Rock Head, Sturdy, Sand Veil'), ('Run Away, Flash Fire, Flame Body'), ('Oblivious, Own Tempo, Regenerator'), ('Magnet Pull, Sturdy, Analytic'), ('Keen Eye, Inner Focus, Defiant'), ('Run Away, Early Bird, Tangled Feet'), ('Thick Fat, Hydration, Ice Body'), ('Stench, Sticky Hold, Poison Touch'), ('Shell Armor, Skill Link, Overcoat'), ('Levitate'), ('Cursed Body'), ('Rock Head, Sturdy, Weak Armor'), ('Insomnia, Forewarn, Inner Focus'), ('Hyper Cutter, Shell Armor, Sheer Force'), ('Soundproof, Static, Aftermath'), ('Chlorophyll, Harvest'), ('Rock Head, Lightning Rod, Battle Armor'), ('Limber, Reckless, Unburden'), ('Keen Eye, Iron Fist, Inner Focus'), ('Own Tempo, Own Tempo, Cloud Nine'), ('Levitate, Neutralizing Gas, Stench'), ('Lightning Rod, Rock Head, Reckless'), ('Natural Cure, Serene Grace, Healer'), ('Chlorophyll, Leaf Guard, Regenerator'), ('Early Bird, Scrappy, Inner Focus'), ('Swift Swim, Sniper,Damp'), ('Poison Point, Sniper,Damp'), ('Swift Swim, Water Veil, Lightning Rod'), ('Illuminate, Natural Cure, Analytic'), ('Soundproof, Filter, Technician'), ('Swarm, Technician, Steadfast'), ('Oblivious, Forewarn, Dry Skin'), ('Static, Vital Spirit'), ('Flame Body, Vital Spirit'), ('Hyper Cutter, Mold Breaker, Moxie'), ('Intimidate, Intimidate, Sheer Force'), ('Swift Swim, Rattled'), ('Intimidate, Moxie'), ('Water Absorb, Shell Armor, Hydration'), ('Limber, Imposter'), ('Run Away, Adaptability, Anticipation'), ('Water Absorb, Hydration'), ('Volt Absorb, Quick Feet'), ('Flash Fire, Guts'), ('Trace, Download, Analytic'), ('Swift Swim, Shell Armor, Weak Armor'), ('Swift Swim, Battle Armor, Weak Armor'), ('Rock Head, Pressure, Unnerve'), ('Immunity, Thick Fat, Gluttony'), ('Pressure, Snow Cloak'), ('Pressure, Static'), ('Pressure, Flame Body'), ('Shed Skin, Marvel Scale'), ('Inner Focus, Multiscale'), ('Pressure, Unnerve'), ('Synchronize');


INSERT INTO Types (name)
VALUES
('Water'), ('Normal'), ('Poison'), ('Fire'), ('Grass, Poison'), ('Normal, Flying'), ('Fight'), ('Psychic'), ('Ground'), ('Ground, Rock'), ('Electric'), ('Bug, Poison'), ('Rock, Water'), ('Poison, Ghost'), ('Bug'), ('Water, Psychic'), ('Water, Ice'), ('Normal, Fairy'), ('Poison, Flying'), ('Bug, Flying'), ('Fire, Flying'), ('Poison, Ground'), ('Water, Poison'), ('Bug, Grass'), ('Electric, Steel'), ('Grass, Psychic'), ('Dragon'), ('Fairy'), ('Water, Fight'), ('Rock, Flying'), ('Water, Flying'), ('Electric, Flying'), ('Ice, Flying'), ('Dragon, Flying'), ('Grass'), ('Ice, Psychic'), ('Psychic, Fairy');


INSERT INTO Pokemon (name, url, gymID, ratingID)
VALUES
('Pikachu', '/static/img/sprites/pikachu-sprite.png', 2, 3),
('Charmander', '/static/img/sprites/charmander-sprite.png', 5, 4),
('Squirtle', '/static/img/sprites/squirtle-sprite.png', 8, 2),
('Psyduck', '/static/img/sprites/psyduck-sprite.png', 3, 4);

INSERT INTO PokemonAbilities (pokemonID, abilityID)
VALUES (1, 15), (2, 2), (3, 3), (4, 4);

INSERT INTO PokemonTypes (pokemonID, typeID)
VALUES (1, 11), (2, 2), (3, 3), (4, 3);
