# Authors:                                Sandro Aguilar and Kuljot Biring
# Date:                                   January 27, 2021
# Class:                                  CS 340
# Description:                            Group project that implements a relational database using
#                                         SQL. Python is used for the back-end.
#

#-------------------------------------------------------------------------
# import the required libraries for the web app and other modules
from flask import Flask, session, render_template, url_for, request, redirect
import mysql.connector
import db_connect
from helpers import build_url, valid_login, build_poke_list, build_gym_location, build_where_condition, save_pokemon


#-------------------------------------------------------------------------
# create the flask app & set app configurations
app = Flask(__name__, static_url_path='/static')

# backend configuration settings
app.secret_key = b'\x1c\x9f\xa4\xac\x1c,\x1a\xf9\xac\x88X\xc1^\xb4V.'


#-------------------------------------------------------------------------
# routes

# home route -----
@app.route('/', methods=['GET', 'POST'])
def index():
  # connect to the DB
  conn = db_connect.connect_db()

  # execute a query
  query = 'SELECT Pokemon.pokemonID, Names.name, Names.imageURL, Types.name, Abilities.abilityName, Ratings.rating, Gyms.location,Ratings.ratingID, Gyms.gymID FROM Pokemon INNER JOIN Ratings ON Pokemon.ratingID = Ratings.ratingID INNER JOIN Names ON Pokemon.NameID = Names.NameID INNER JOIN Gyms ON Pokemon.gymID = Gyms.gymID INNER JOIN PokemonAbilities ON Pokemon.pokemonID = PokemonAbilities.pokemonID INNER JOIN PokemonTypes ON Pokemon.pokemonID = PokemonTypes.pokemonID INNER JOIN Abilities ON PokemonAbilities.abilityID = Abilities.abilityID INNER JOIN Types ON Types.typeID = PokemonTypes.typeID ORDER BY Pokemon.pokemonID ASC'
  query_results = db_connect.execute_db_query(conn, query).fetchall()

  # database actions - populate dropdown menus
  query = 'SELECT name FROM Names'
  name_data = db_connect.execute_db_query(conn, query).fetchall()
  # print(f'Name data: {name_data}')

  query = 'SELECT * FROM Types'
  type_data = db_connect.execute_db_query(conn, query).fetchall()
  # print(f'Name data: {type_data}')

  query = 'SELECT * FROM Abilities'
  ability_data = db_connect.execute_db_query(conn, query).fetchall()
  # print(f'Name data: {ability_data}')

  query = 'SELECT * FROM Ratings'
  rating_data = db_connect.execute_db_query(conn, query).fetchall()
  # print(f'Rating data: {rating_data}')

  query = 'SELECT * FROM Gyms'
  gym_data = db_connect.execute_db_query(conn, query).fetchall()

  # render home page
  return render_template('home.html', poke_list=query_results, name_data=name_data, type_data=type_data, ability_data=ability_data, rating_data=rating_data, gym_data=gym_data)


# administrator login page -----
@app.route('/login', methods=['GET', 'POST'])
def login():
  # check if user is already logged in and route to admin page if yes
  print(session)
  if 'username' in session:
    print('Admin in session')
    return render_template('/admin_menu.html')

  # if POST request is received, then log into site
  error = None
  if request.method == 'POST':
    req = request.form
    username = req['username']
    password = req['password']
    if valid_login(username, password):
      msg = "Admin Main Menu"
      session['username'] = username
      return redirect(url_for('admin_menu'))
    else:
      error = 'Invalid username/password'
      return render_template('admin_login.html', error=error)
  else:
    return render_template('admin_login.html')


# administrator validate login and menu page -----
@app.route('/admin-menu', methods=['GET', 'POST'])
def admin_menu():
  if 'username' in session:
    return render_template('admin_menu.html')
  return render_template('admin_login.html')


# admin logout route -----
@app.route('/logout')
def logout():
  # remove the username from the session if its there
  session.pop('username', None)
  print(session)
  return redirect(url_for('index'))


# edit pokemon route -----
@app.route('/add-pokemon', methods=['GET', 'POST'])
def add_pokemon():
  # if POST request is received, add Pokemon to database
  if request.method == 'POST':
    print('POST request received -- /add-pokemon\n')

    # get add pokemon form values
    req = request.form
    print('Form Data Received:')
    print(req,'\n')
    pokemon = req['selectPokemon']
    pokeType = req['selectType']
    abilities = req['selectAbilities']
    rating = req['selectRating']
    gym = req['selectGym']
    url = f'/static/img/sprites/{pokemon.lower()}-sprite.png'
    gymID = None;
    ratingID = None;

    # database action - connect to database
    conn = db_connect.connect_db()

    # database action - get pokemonNameID from DB
    query = f'SELECT nameID FROM Names WHERE name = "{pokemon}"'
    query_results = db_connect.execute_db_query(conn, query).fetchall()
    name_id = query_results[0][0]
    print(f'Pokemon Name ID: {name_id}')

    # database action - get imageID from DB
    query = f'SELECT Names.imageURL FROM Names WHERE name = "{pokemon}"'
    query_results = db_connect.execute_db_query(conn, query).fetchall()
    image_url = query_results[0][0]
    print(f'Pokemon Image URL: {image_url}')

    # database action - get abilities ID from DB
    query = f'SELECT abilityID FROM Abilities WHERE abilityName = "{abilities}"'
    query_results = db_connect.execute_db_query(conn, query).fetchall()
    ability_id = query_results[0][0]
    # ability_id = abilities
    print(f'ability id: {ability_id}')

    # database action - get type ID from DB
    query = f'SELECT typeID FROM Types WHERE name = "{pokeType}"'
    query_results = db_connect.execute_db_query(conn, query).fetchall()
    type_id = query_results[0][0]
    # type_id = pokeType
    print(f'type_id: {type_id}')

    # database action - get Gym ID from DB
    query = f'SELECT gymID FROM Gyms WHERE gymName = "{gym}"'
    gym_id = gym
    print(f'gym_id: {gym_id}')

    # database action - get Rating ID from DB
    query = f'SELECT ratingID FROM Ratings WHERE rating = "{rating}"'
    rating_id = rating
    print(f'rating_id: {rating_id}')

    # database actions - INSERT pokemon into Pokemon table
    query = 'INSERT INTO Pokemon (nameID, gymID, ratingID) VALUES (%s, %s, %s)'
    print(f'Query args: {name_id}, {image_url}, {gym_id}, {rating_id}')
    query_args = (name_id, gym_id, rating_id)
    query_results = db_connect.execute_db_query(conn, query, query_args).lastrowid
    conn.commit()

    # insert pokemonType relation
    print('POKEMON INSERT - - - - - - - - - - -')

    # database actions - get pokemonID of pokemon inserted
    pokemon_id = query_results

    # database actions - insert into PokemonAbilities
    query = 'INSERT INTO PokemonAbilities (pokemonID, abilityID) VALUES (%s, %s)'
    query_args = (pokemon_id, ability_id)
    query_results = db_connect.execute_db_query(conn, query, query_args).fetchall()
    conn.commit()

    # database actions - insert into PokemonTypes
    query = 'INSERT INTO PokemonTypes (pokemonID, typeID) VALUES (%s, %s)'
    query_args = (pokemon_id, type_id)
    query_results = db_connect.execute_db_query(conn, query, query_args)
    conn.commit()

    return redirect('/')
  return render_template('home.html')

# add to tables routes -----
@app.route('/create-pokemon', methods=['GET', 'POST'])
def create_pokemon():
  if request.method == 'POST':
    print(request.form)
    new_pokemon_name = request.form.get('createNameInput')
    new_pokemon_url = request.form.get('createUrlInput')
    # create db action
    conn = db_connect.connect_db()
    query = 'INSERT INTO Names (name, imageURL) VALUES (%s, %s)'
    url = build_url(new_pokemon_name)
    query_args = (new_pokemon_name, url)
    query_results = db_connect.execute_db_query(conn, query, query_args).rowcount
    conn.commit()
    print(f'Insertion(s) made: {query_results}')
    return redirect(url_for('admin_menu'))
  return render_template('admin_create_pokemon.html')

@app.route('/add-gym', methods=['GET', 'POST'])
def addGym():
  if request.method == 'POST':
    print(request.form)
    new_gym_name = request.form.get('addGymInput')
    new_gym_location = request.form.get('addGymLocationInput')
    # create db action
    conn = db_connect.connect_db()
    query = 'INSERT INTO Gyms (gymName, location) VALUES (%s, %s)'
    gym_name, location = build_gym_location(new_gym_location)
    query_args = (gym_name, location)
    query_results = db_connect.execute_db_query(conn, query, query_args).rowcount
    conn.commit()
    print(f'Insertion(s) made: {query_results}')
    return redirect(url_for('admin_menu'))
  return render_template('admin_add_gym.html')

@app.route('/add-rating', methods=['GET', 'POST'])
def addRoute():
  if request.method == 'POST':
    print(request.form)
    new_rating = request.form.get('addRatingInput')
    # create db action
    conn = db_connect.connect_db()
    query = 'INSERT INTO Ratings (rating) VALUES (%s)'
    query_args = (new_rating,)
    query_results = db_connect.execute_db_query(conn, query, query_args).rowcount
    conn.commit()
    print(f'Insertion(s) made: {query_results}')
    return redirect(url_for('admin_menu'))
  return render_template('admin_add_rating.html')

@app.route('/add-ability', methods=['GET', 'POST'])
def addAbility():
  if request.method == 'POST':
    print(request.form)
    new_ability = request.form.get('addAbilityInput')
    # create db action
    conn = db_connect.connect_db()
    query = 'INSERT INTO Abilities (abilityName) VALUES (%s)'
    query_args = (new_ability,)
    query_results = db_connect.execute_db_query(conn, query, query_args).rowcount
    conn.commit()
    print(f'Insertion(s) made: {query_results}')
    return redirect(url_for('admin_menu'))
  return render_template('admin_add_ability.html')

@app.route('/add-type', methods=['GET', 'POST'])
def addType():
  if request.method == 'POST':
    print(request.form)
    new_type = request.form.get('addTypeInput')
    # create db action
    conn = db_connect.connect_db()
    query = 'INSERT INTO Types (name) VALUES (%s)'
    query_args = (new_type,)
    query_results = db_connect.execute_db_query(conn, query, query_args).rowcount
    conn.commit()
    print(f'Insertion(s) made: {query_results}')
    return redirect(url_for('admin_menu'))
  return render_template('admin_add_type.html')

@app.route('/search', methods=['GET', 'POST'])
def search():
  if request.method == 'GET':
    print(request.args)
    search_terms = request.args.get('search_value', '')
    search_type = request.args.get('search_type', '')
    print(f'Search type: {search_type}')
    modifier = ''
    where_clause = ''
    # create db action
    conn = db_connect.connect_db()

    query = 'SELECT Pokemon.pokemonID, Names.name, Names.imageURL, Types.name, Abilities.abilityName, Ratings.rating, Gyms.location,Ratings.ratingID, Gyms.gymID FROM Pokemon INNER JOIN Ratings ON Pokemon.ratingID = Ratings.ratingID INNER JOIN Names ON Pokemon.NameID = Names.NameID INNER JOIN Gyms ON Pokemon.gymID = Gyms.gymID INNER JOIN PokemonAbilities ON Pokemon.pokemonID = PokemonAbilities.pokemonID INNER JOIN PokemonTypes ON Pokemon.pokemonID = PokemonTypes.pokemonID INNER JOIN Abilities ON PokemonAbilities.abilityID = Abilities.abilityID INNER JOIN Types ON Types.typeID = PokemonTypes.typeID WHERE '

    if search_type == 'Names':
      where_clause = 'Pokemon.nameID = Names.nameID AND '
      query += where_clause
      modifier = 'Names.name'
    elif search_type == 'Types':
      where_clause = 'Pokemon.pokemonID = PokemonTypes.pokemonID AND PokemonTypes.typeID = Types.typeID AND '
      query += where_clause
      modifier = 'Types.name'
    elif search_type == 'Abilities':
      where_clause = 'Pokemon.pokemonID = PokemonAbilities.pokemonID AND pokemonAbilities.abilityID = Abilities.abilityID AND '
      query += where_clause
      modifier = 'Abilities.abilityName'
    elif search_type == 'Ratings':
      where_clause = 'Pokemon.ratingID = Ratings.ratingID AND '
      query += where_clause
      modifier = 'Ratings.rating'
    elif search_type == 'Gyms':
      where_clause = 'Pokemon.gymID = Gyms.gymID AND '
      query += where_clause
      modifier = 'Gyms.gymName'

    # build where condition in query
    where_condition = build_where_condition(search_terms, modifier)
    if where_condition:
      query += where_condition
    # print(query)
    query_results = db_connect.execute_db_query(conn, query).fetchall()
    print(query_results)

    return render_template('search.html', pokemon_list=query_results, terms=search_terms, search_type=search_type)
  return render_template('search.html')


# add PokemonAbilities intersection table
@app.route('/add-pokemon-ability', methods=['GET', 'POST'])
def add_ability_pokemon():
  # generate dropdown of pokemons
  # connect to the DB
  conn = db_connect.connect_db()
  # get Pokemon already in database to generate dropdown menu
  query = 'SELECT Pokemon.pokemonID, Names.name FROM Pokemon INNER JOIN Names on Pokemon.nameID = Names.nameID'
  poke_list = db_connect.execute_db_query(conn, query).fetchall()
  print(poke_list)
  # get Abilities in database to generate dropdown menu
  query = 'SELECT * FROM Abilities'
  abilities_list = db_connect.execute_db_query(conn, query).fetchall()
  print(abilities_list)

  # insert into PokemonAbilities table
  if request.method == 'POST':
    req = request.form
    print(req, '\n')
    pokemon = req.get('selectPokemon')
    ability = req.get('selectAbilities')
    print(f'Form values: {pokemon}, {ability}')
    # get pokemonID
    print(f'Pokemon selected: {pokemon}')
    query = f'SELECT Pokemon.pokemonID, Names.name FROM Pokemon INNER JOIN Names on Pokemon.nameID = Names.nameID WHERE Names.name = "{pokemon}"'
    query_results = db_connect.execute_db_query(conn, query).fetchall()
    print(query_results)
    pokemon_id = query_results[0][0]
    print(f'PokemonID: {pokemon_id}')
    # get abilittyID
    query = f'SELECT * FROM Abilities WHERE abilityID = {ability}'
    query_results = db_connect.execute_db_query(conn, query).fetchall()
    print(query_results)
    ability_id = query_results[0][0]
    # INSERT entry into PokemonAbility table
    query = f'INSERT INTO PokemonAbilities (pokemonID, abilityID) VALUES ({pokemon_id}, {ability_id})'
    query_results = db_connect.execute_db_query(conn, query).rowcount
    conn.commit()
    print(f'Insertion(s) made: {query_results}')

    return redirect(url_for('admin_menu'))
  return render_template('admin_add_ability_relation.html', poke_list=poke_list, abilities_list=abilities_list)

# add PokemonTypes intersection table
@app.route('/add-pokemon-type', methods=['GET', 'POST'])
def add_pokemon_type():
  # generate dropdown of pokemons
  # connect to the DB
  conn = db_connect.connect_db()
  # get Pokemon already in database to generate dropdown menu
  query = 'SELECT Pokemon.pokemonID, Names.name FROM Pokemon INNER JOIN Names on Pokemon.nameID = Names.nameID'
  name_list = db_connect.execute_db_query(conn, query).fetchall()
  print(name_list)
  # get Types in database to generate dropdown menu
  query = 'SELECT * FROM Types'
  types_list = db_connect.execute_db_query(conn, query).fetchall()
  print(types_list)

  if request.method == 'POST':
    req = request.form
    print(req, '\n')
    pokemon = req.get('selectPokemon')
    type = req.get('selectType')
    print(f'Form values: {pokemon}, {type}')
    # get pokemonID
    print(f'Pokemon selected: {pokemon}')
    query = f'SELECT Pokemon.pokemonID, Names.name FROM Pokemon INNER JOIN Names on Pokemon.nameID = Names.nameID WHERE Names.name = "{pokemon}"'
    query_results = db_connect.execute_db_query(conn, query).fetchall()
    print(query_results)
    pokemon_id = query_results[0][0]
    print(f'PokemonID: {pokemon_id}')
    # get typeID
    query = f'SELECT * FROM Types WHERE typeID = {type}'
    query_results = db_connect.execute_db_query(conn, query).fetchall()
    print(query_results)
    type_id = query_results[0][0]
    # INSERT entry into PokemonTypes table
    query = f'INSERT INTO PokemonTypes (pokemonID, typeID) VALUES ({pokemon_id}, {type_id})'
    query_results = db_connect.execute_db_query(conn, query).rowcount
    conn.commit()
    print(f'Insertion(s) made: {query_results}')

    return redirect(url_for('admin_menu'))
  return render_template('admin_add_type_relation.html', name_list=name_list, types_list=types_list)


# delete pokemon route
@app.route('/delete-pokemon', methods=['GET', 'POST'])
def delete():
  if request.method == "POST":
    # get form values
    pokemon_id = request.form.get('pokemonID')
    # connect to the DB
    conn = db_connect.connect_db()
    # use pokemonID from form to delete pokemon row in Pokemons table
    query = 'DELETE FROM PokemonAbilities WHERE pokemonID = %s'
    args = (pokemon_id,)
    query_results = db_connect.execute_db_query(conn, query, args).rowcount
    conn.commit()
    query = 'DELETE FROM PokemonTypes WHERE pokemonID = %s'
    query_results = db_connect.execute_db_query(conn, query, args).rowcount
    conn.commit()
    query = 'DELETE FROM Pokemon WHERE pokemonID = %s'
    query_results = db_connect.execute_db_query(conn, query, args).rowcount
    conn.commit()
    return redirect(url_for('index'))
  return redirect(url_for('index'))



# edit pokemon route
@app.route('/edit-pokemon', methods=['GET', 'POST'])
def edit_pokemon():
  if request.method == 'POST':
    # save form values
    req = request.form
    pokemon_id = req.get('pokemon_id')
    new_name = req.get('editName')
    new_gym = req.get('changeGym')
    new_rating = req.get('changeRating')
    new_abilities = req.get('changeAbilities')
    new_type = req.get('changeType')

    # connct to DB
    conn = db_connect.connect_db()

    # UPDATE Gyms table
    query = f'UPDATE Pokemon SET gymID = {new_gym} WHERE pokemonID = {pokemon_id}'
    query_results = db_connect.execute_db_query(conn, query).rowcount
    conn.commit()

    # UPDATE Ratings table
    query = f'UPDATE Pokemon SET ratingID = {new_rating} WHERE pokemonID = {pokemon_id}'
    query_results = db_connect.execute_db_query(conn, query).rowcount
    conn.commit()

    # UPDATE Pokemon Abilitieis - get abilitiesID from Abilities
    query = f'SELECT * FROM Abilities WHERE abilityName = "{new_abilities}"'
    query_results = db_connect.execute_db_query(conn, query).fetchone()
    new_ability_id = query_results[0]

    # delete entry into intersection table
    query = f'UPDATE PokemonAbilities SET abilityID = {new_ability_id} WHERE pokemonID = {pokemon_id}'
    query_results = db_connect.execute_db_query(conn, query).rowcount
    conn.commit()

    # UPDATE Pokemon Types
    query = f'SELECT * FROM Types WHERE name = "{new_type}"'
    query_results = db_connect.execute_db_query(conn, query).fetchone()
    new_type_id = query_results[0]

    # delete entry into tersection table
    query = f'UPDATE PokemonTypes SET typeID = {new_type_id} WHERE pokemonID = {pokemon_id}'
    query_results = db_connect.execute_db_query(conn, query).rowcount
    conn.commit()

    # UPDATE pokemon Name table - get nameID from Name table
    query = f'SELECT * FROM Names WHERE NAME = "{new_name}"'
    query_results = db_connect.execute_db_query(conn, query).fetchone()
    new_name_id = query_results[0]

    # assign new nameID to Pokemon table
    query = f'UPDATE Pokemon SET nameID = {new_name_id} WHERE pokemonID = {pokemon_id}'
    query_results = db_connect.execute_db_query(conn, query).rowcount
    conn.commit()
    return redirect(url_for('index'))
  return redirect(url_for('index'))



# create database -----
@app.route('/create-db')
def create_db():
  print("Connect to DB starting")
  conn = db_connect.create_database()
  mycursor = conn.cursor()
  mycursor.execute('SHOW DATABASES')

  # check existing databases and return page if group database
  # already exists
  for x in mycursor:
    print(x)
    db = 'cs340_project'
    if db in x:
      print('Database found ****************')
      return render_template('create_db.html')

  # create the group project database if it does not exist
  # and return page
  print('Creating database *************')
  mycursor.execute('CREATE DATABASE cs340_project')
  return render_template('create_db.html')



# route errors -----
@app.errorhandler(404)
def page_not_found(error):
  msg = "Oh snap, the page you requested was not found"
  return render_template('not_found.html', results=msg), 404

@app.errorhandler(500)
def server_error(error):
  msg = "Oh snap, it looks like the programmers made a boo boo. Go to the main page to clear this up."
  return render_template('server_error.html', results=msg), 500



#-------------------------------------------------------------------------
# Start Web App
if __name__ == "__main__":
    app.run(host='localhost', port=44041, debug=True)

# OSU - run from osu servers
# gunicorn -b 0.0.0.0:{any_valid_port} -D app:app