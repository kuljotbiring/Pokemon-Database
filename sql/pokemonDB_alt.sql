-- Author:          Sandro Aguilar and Kuljot Biring
-- Class:           CS 340
-- Description:     DDL SQL File: Create and Seed Database
-- Notes:           This file can be directly imported into phpMyAdmin.


-- -------------------------------------------------------------------------
-- a) DDL Queries
-- -------------------------------------------------------------------------

-- Drop prior tables and reset this database
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Pokemon;
DROP TABLE IF EXISTS PokemonAbilities;
DROP TABLE IF EXISTS PokemonTypes;
DROP TABLE IF EXISTS Gyms;
DROP TABLE IF EXISTS Ratings;
DROP TABLE IF EXISTS Names;
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

CREATE TABLE Names (
  nameID int(11) NOT NULL AUTO_INCREMENT,
  name varchar(255) NOT NULL,
  imageURL varchar(255) NOT NULL,
  PRIMARY KEY (NameID)
);

CREATE TABLE Pokemon (
  pokemonID int(11) NOT NULL AUTO_INCREMENT,
  nameID int(11) NOT NULL,
  gymID int(11),
  ratingID int(11),
  FOREIGN KEY(nameID) REFERENCES Names(nameID) ON DELETE NO ACTION ON UPDATE CASCADE,
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

INSERT INTO Names (name, imageURL)
VALUES
('Bulbasaur', 'static/img/sprites/bulbasaur-sprite.png'),('Ivysaur', 'static/img/sprites/ivysaur-sprite.png'),('Venusaur', 'static/img/sprites/venusaur-sprite.png'),('Charmander', 'static/img/sprites/charmander-sprite.png'),('Charmeleon', 'static/img/sprites/charmeleon-sprite.png'),('Charizard', 'static/img/sprites/charizard-sprite.png'),('Squirtle', 'static/img/sprites/squirtle-sprite.png'),('Wartortle', 'static/img/sprites/wartortle-sprite.png'),('Blastoise', 'static/img/sprites/blastoise-sprite.png'),('Caterpie', 'static/img/sprites/caterpie-sprite.png'),('Metapod', 'static/img/sprites/metapod-sprite.png'),('Butterfree', 'static/img/sprites/butterfree-sprite.png'),('Weedle', 'static/img/sprites/weedle-sprite.png'),('Kakuna', 'static/img/sprites/kakuna-sprite.png'),('Beedrill', 'static/img/sprites/beedrill-sprite.png'),('Pidgey', 'static/img/sprites/pidgey-sprite.png'),('Pidgeotto', 'static/img/sprites/pidgeotto-sprite.png'),('Pidgeot', 'static/img/sprites/pidgeot-sprite.png'),('Rattata', 'static/img/sprites/rattata-sprite.png'),('Raticate', 'static/img/sprites/raticate-sprite.png'),('Spearow', 'static/img/sprites/spearow-sprite.png'),('Fearow', 'static/img/sprites/fearow-sprite.png'),('Ekans', 'static/img/sprites/ekans-sprite.png'),('Arbok', 'static/img/sprites/arbok-sprite.png'),('Pikachu', 'static/img/sprites/pikachu-sprite.png'),('Raichu', 'static/img/sprites/raichu-sprite.png'),('Sandshrew', 'static/img/sprites/sandshrew-sprite.png'),('Sandslash', 'static/img/sprites/sandslash-sprite.png'),('Nidoran', 'static/img/sprites/nidoran-sprite.png'),('Nidorina', 'static/img/sprites/nidorina-sprite.png'),('Nidoqueen', 'static/img/sprites/nidoqueen-sprite.png'),('Nidorano', 'static/img/sprites/nidorano-sprite.png'),('Nidorino', 'static/img/sprites/nidorino-sprite.png'),('Nidoking', 'static/img/sprites/nidoking-sprite.png'),('Clefairy', 'static/img/sprites/clefairy-sprite.png'),('Clefable', 'static/img/sprites/clefable-sprite.png'),('Vulpix', 'static/img/sprites/vulpix-sprite.png'),('Ninetales', 'static/img/sprites/ninetales-sprite.png'),('Jigglypuff', 'static/img/sprites/jigglypuff-sprite.png'),('Wigglytuff', 'static/img/sprites/wigglytuff-sprite.png'),('Zubat', 'static/img/sprites/zubat-sprite.png'),('Golbat', 'static/img/sprites/golbat-sprite.png'),('Oddish', 'static/img/sprites/oddish-sprite.png'),('Gloom', 'static/img/sprites/gloom-sprite.png'),('Vileplume', 'static/img/sprites/vileplume-sprite.png'),('Paras', 'static/img/sprites/paras-sprite.png'),('Parasect', 'static/img/sprites/parasect-sprite.png'),('Venonat', 'static/img/sprites/venonat-sprite.png'),('Venomoth', 'static/img/sprites/venomoth-sprite.png'),('Diglett', 'static/img/sprites/diglett-sprite.png'),('Dugtrio', 'static/img/sprites/dugtrio-sprite.png'),('Meowth', 'static/img/sprites/meowth-sprite.png'),('Persian', 'static/img/sprites/persian-sprite.png'),('Psyduck', 'static/img/sprites/psyduck-sprite.png'),('Golduck', 'static/img/sprites/golduck-sprite.png'),('Mankey', 'static/img/sprites/mankey-sprite.png'),('Primeape', 'static/img/sprites/primeape-sprite.png'),('Growlithe', 'static/img/sprites/growlithe-sprite.png'),('Arcanine', 'static/img/sprites/arcanine-sprite.png'),('Poliwag', 'static/img/sprites/poliwag-sprite.png'),('Poliwhirl', 'static/img/sprites/poliwhirl-sprite.png'),('Poliwrath', 'static/img/sprites/poliwrath-sprite.png'),('Abra', 'static/img/sprites/abra-sprite.png'),('Kadabra', 'static/img/sprites/kadabra-sprite.png'),('Alakazam', 'static/img/sprites/alakazam-sprite.png'),('Machop', 'static/img/sprites/machop-sprite.png'),('Machoke', 'static/img/sprites/machoke-sprite.png'),('Machamp', 'static/img/sprites/machamp-sprite.png'),('Bellsprout', 'static/img/sprites/bellsprout-sprite.png'),('Weepinbell', 'static/img/sprites/weepinbell-sprite.png'),('Victreebel', 'static/img/sprites/victreebel-sprite.png'),('Tentacool', 'static/img/sprites/tentacool-sprite.png'),('Tentacruel', 'static/img/sprites/tentacruel-sprite.png'),('Geodude', 'static/img/sprites/geodude-sprite.png'),('Graveler', 'static/img/sprites/graveler-sprite.png'),('Golem', 'static/img/sprites/golem-sprite.png'),('Ponyta', 'static/img/sprites/ponyta-sprite.png'),('Rapidash', 'static/img/sprites/rapidash-sprite.png'),('Slowpoke', 'static/img/sprites/slowpoke-sprite.png'),('Slowbro', 'static/img/sprites/slowbro-sprite.png'),('Magnemite', 'static/img/sprites/magnemite-sprite.png'),('Magneton', 'static/img/sprites/magneton-sprite.png'),("Farfetch'd", "static/img/sprites/farfetch'd-sprite.png"),('Doduo', 'static/img/sprites/doduo-sprite.png'),('Dodrio', 'static/img/sprites/dodrio-sprite.png'),('Seel', 'static/img/sprites/seel-sprite.png'),('Dewgong', 'static/img/sprites/dewgong-sprite.png'),('Grimer', 'static/img/sprites/grimer-sprite.png'),('Muk', 'static/img/sprites/muk-sprite.png'),('Shellder', 'static/img/sprites/shellder-sprite.png'),('Cloyster', 'static/img/sprites/cloyster-sprite.png'),('Gastly', 'static/img/sprites/gastly-sprite.png'),('Haunter', 'static/img/sprites/haunter-sprite.png'),('Gengar', 'static/img/sprites/gengar-sprite.png'),('Onix', 'static/img/sprites/onix-sprite.png'),('Drowzee', 'static/img/sprites/drowzee-sprite.png'),('Hypno', 'static/img/sprites/hypno-sprite.png'),('Krabby', 'static/img/sprites/krabby-sprite.png'),('Kingler', 'static/img/sprites/kingler-sprite.png'),('Voltorb', 'static/img/sprites/voltorb-sprite.png'),('Electrode', 'static/img/sprites/electrode-sprite.png'),('Exeggcute', 'static/img/sprites/exeggcute-sprite.png'),('Exeggutor', 'static/img/sprites/exeggutor-sprite.png'),('Cubone', 'static/img/sprites/cubone-sprite.png'),('Marowak', 'static/img/sprites/marowak-sprite.png'),('Hitmonlee', 'static/img/sprites/hitmonlee-sprite.png'),('Hitmonchan', 'static/img/sprites/hitmonchan-sprite.png'),('Lickitung', 'static/img/sprites/lickitung-sprite.png'),('Koffing', 'static/img/sprites/koffing-sprite.png'),('Weezing', 'static/img/sprites/weezing-sprite.png'),('Rhyhorn', 'static/img/sprites/rhyhorn-sprite.png'),('Rhydon', 'static/img/sprites/rhydon-sprite.png'),('Chansey', 'static/img/sprites/chansey-sprite.png'),('Tangela', 'static/img/sprites/tangela-sprite.png'),('Kangaskhan', 'static/img/sprites/kangaskhan-sprite.png'),('Horsea', 'static/img/sprites/horsea-sprite.png'),('Seadra', 'static/img/sprites/seadra-sprite.png'),('Goldeen', 'static/img/sprites/goldeen-sprite.png'),('Seaking', 'static/img/sprites/seaking-sprite.png'),('Staryu', 'static/img/sprites/staryu-sprite.png'),('Starmie', 'static/img/sprites/starmie-sprite.png'),('Mr. Mime', 'static/img/sprites/mr. mime-sprite.png'),('Scyther', 'static/img/sprites/scyther-sprite.png'),('Jynx', 'static/img/sprites/jynx-sprite.png'),('Electabuzz', 'static/img/sprites/electabuzz-sprite.png'),('Magmar', 'static/img/sprites/magmar-sprite.png'),('Pinsir', 'static/img/sprites/pinsir-sprite.png'),('Tauros', 'static/img/sprites/tauros-sprite.png'),('Magikarp', 'static/img/sprites/magikarp-sprite.png'),('Gyarados', 'static/img/sprites/gyarados-sprite.png'),('Lapras', 'static/img/sprites/lapras-sprite.png'),('Ditto', 'static/img/sprites/ditto-sprite.png'),('Eevee', 'static/img/sprites/eevee-sprite.png'),('Vaporeon', 'static/img/sprites/vaporeon-sprite.png'),('Jolteon', 'static/img/sprites/jolteon-sprite.png'),('Flareon', 'static/img/sprites/flareon-sprite.png'),('Porygon', 'static/img/sprites/porygon-sprite.png'),('Omanyte', 'static/img/sprites/omanyte-sprite.png'),('Omastar', 'static/img/sprites/omastar-sprite.png'),('Kabuto', 'static/img/sprites/kabuto-sprite.png'),('Kabutops', 'static/img/sprites/kabutops-sprite.png'),('Aerodactyl', 'static/img/sprites/aerodactyl-sprite.png'),('Snorlax', 'static/img/sprites/snorlax-sprite.png'),('Articuno', 'static/img/sprites/articuno-sprite.png'),('Zapdos', 'static/img/sprites/zapdos-sprite.png'),('Moltres', 'static/img/sprites/moltres-sprite.png'),('Dratini', 'static/img/sprites/dratini-sprite.png'),('Dragonair', 'static/img/sprites/dragonair-sprite.png'),('Dragonite', 'static/img/sprites/dragonite-sprite.png'),('Mewtwo', 'static/img/sprites/mewtwo-sprite.png'),('Mew', 'static/img/sprites/mew-sprite.png');

INSERT INTO Abilities (abilityName)
VALUES
('Overgrow, Chlorophyll'), ('Blaze, Solar Power'), ('Torrent, Rain Dish'), ('Shield Dust, Run Away'), ('Shed Skin'), ('Compoundeyes, Tinted Lens'), ('Shield Dust, Run Away'), ('Poison'), ('Swarm, Sniper'), ('Keen Eye, Tangled Feet, Big Pecks'), ('Rattata, Guts, Hustle'), ('Run Away, Guts, Hustle'), ('Keen Eye, Sniper'), ('Intimidate, Shed Skin, Unnerve'), ('Static, Lightning Rod'), ('Sand Veil, Sand Rush'), ('Poison Point, Rivalry, Hustle'), ('Poison Point, Rivalry, Sheer Force'), ('Poison Point, Rivalry, Hustle'), ('Poison Point, Rivalry, Sheer Force'), ('Cute Charm, Magic Guard, Friend Guard'), ('Cute Charm, Magic Guard, Unaware'), ('Flash Fire, Drought'), ('Cute Charm, Competitive, Friend Guard'), ('Cute Charm, Competitive, Frisk'), ('Inner Focus, Infiltrator'), ('Chlorophyll, Run Away'), ('Chlorophyll, Stench'), ('Chlorophyll, Effect Spore'), ('Effect Spore, Dry Skin,Damp'), ('Compoundeyes, Tinted Lens, Run Away'), ('Shield Dust, Tinted Lens, Wonder Skin'), ('Sand Veil, Arena Trap, Sand Force'), ('Pickup, Technician, Unnerve'), ('Limber, Technician, Unnerve'), ('Damp, Cloud Nine, Swift Swim'), ('Vital Spirit, Anger Point, Defiant'), ('Intimidate, Flash Fire, Justified'), ('Water Absorb, Damp, Swift Swim'), ('Synchronize, Inner Focus, Magic Guard'), ('Guts, No Guard, Steadfast'), ('Poison, Chlorophyll, Gluttony'), ('Clear Body, Liquid Ooze, Rain Dish'), ('Rock Head, Sturdy, Sand Veil'), ('Run Away, Flash Fire, Flame Body'), ('Oblivious, Own Tempo, Regenerator'), ('Magnet Pull, Sturdy, Analytic'), ('Keen Eye, Inner Focus, Defiant'), ('Run Away, Early Bird, Tangled Feet'), ('Thick Fat, Hydration, Ice Body'), ('Stench, Sticky Hold, Poison Touch'), ('Shell Armor, Skill Link, Overcoat'), ('Levitate'), ('Cursed Body'), ('Rock Head, Sturdy, Weak Armor'), ('Insomnia, Forewarn, Inner Focus'), ('Hyper Cutter, Shell Armor, Sheer Force'), ('Soundproof, Static, Aftermath'), ('Chlorophyll, Harvest'), ('Rock Head, Lightning Rod, Battle Armor'), ('Limber, Reckless, Unburden'), ('Keen Eye, Iron Fist, Inner Focus'), ('Own Tempo, Own Tempo, Cloud Nine'), ('Levitate, Neutralizing Gas, Stench'), ('Lightning Rod, Rock Head, Reckless'), ('Natural Cure, Serene Grace, Healer'), ('Chlorophyll, Leaf Guard, Regenerator'), ('Early Bird, Scrappy, Inner Focus'), ('Swift Swim, Sniper,Damp'), ('Poison Point, Sniper,Damp'), ('Swift Swim, Water Veil, Lightning Rod'), ('Illuminate, Natural Cure, Analytic'), ('Soundproof, Filter, Technician'), ('Swarm, Technician, Steadfast'), ('Oblivious, Forewarn, Dry Skin'), ('Static, Vital Spirit'), ('Flame Body, Vital Spirit'), ('Hyper Cutter, Mold Breaker, Moxie'), ('Intimidate, Intimidate, Sheer Force'), ('Swift Swim, Rattled'), ('Intimidate, Moxie'), ('Water Absorb, Shell Armor, Hydration'), ('Limber, Imposter'), ('Run Away, Adaptability, Anticipation'), ('Water Absorb, Hydration'), ('Volt Absorb, Quick Feet'), ('Flash Fire, Guts'), ('Trace, Download, Analytic'), ('Swift Swim, Shell Armor, Weak Armor'), ('Swift Swim, Battle Armor, Weak Armor'), ('Rock Head, Pressure, Unnerve'), ('Immunity, Thick Fat, Gluttony'), ('Pressure, Snow Cloak'), ('Pressure, Static'), ('Pressure, Flame Body'), ('Shed Skin, Marvel Scale'), ('Inner Focus, Multiscale'), ('Pressure, Unnerve'), ('Synchronize');

INSERT INTO Types (name)
VALUES
('Water'), ('Normal'), ('Poison'), ('Fire'), ('Grass, Poison'), ('Normal, Flying'), ('Fight'), ('Psychic'), ('Ground'), ('Ground, Rock'), ('Electric'), ('Bug, Poison'), ('Rock, Water'), ('Poison, Ghost'), ('Bug'), ('Water, Psychic'), ('Water, Ice'), ('Normal, Fairy'), ('Poison, Flying'), ('Bug, Flying'), ('Fire, Flying'), ('Poison, Ground'), ('Water, Poison'), ('Bug, Grass'), ('Electric, Steel'), ('Grass, Psychic'), ('Dragon'), ('Fairy'), ('Water, Fight'), ('Rock, Flying'), ('Water, Flying'), ('Electric, Flying'), ('Ice, Flying'), ('Dragon, Flying'), ('Grass'), ('Ice, Psychic'), ('Psychic, Fairy');

INSERT INTO Pokemon (nameID, gymID, ratingID)
VALUES
(25, 2, 3),
(3, 5, 4),
(4, 8, 2),
(6, 6, 3),
(7, 7, 5),
(151, 8, 5),
(43, 4, 1);

INSERT INTO PokemonAbilities (pokemonID, abilityID)
VALUES (1, 15), (2, 3), (3, 2), (4, 2), (5, 3), (6, 99), (7, 27);

INSERT INTO PokemonTypes (pokemonID, typeID)
VALUES (1, 11), (2, 5), (3, 4), (4, 4), (5, 1), (6, 8), (7, 5);
