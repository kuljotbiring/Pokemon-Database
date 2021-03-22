# Authors:                                Sandro Aguilar
# Date:                                   February 4, 2021
# Class:                                  CS 340
# Description:                            helpers.py contains various helper functions that are used in
#                                         throughout app.py.

# validates a user's username and password
def valid_login(username, password):
  if username == 'admin' and password == 'admin':
    return True
  return False


def build_poke_list(query_results):
  poke_list = []
  poke_attr = ('id', 'name', 'url', 'type', 'ability', 'rating', 'gym')
  # save Pokemon data into a Dict and push into a list
  for data in query_results:
    it = iter(data)
    keys = iter(poke_attr)
    poke_dict = dict(zip(keys, it))
    poke_list.append(poke_dict)

  return poke_list


def build_url(pokemon_name):
  url = f'static/img/sprites/{pokemon_name.lower()}-sprite.png'
  return url


def build_gym_location(city):
  gym_name = f'{city.capitalize()} City Gym'
  location = f'{city.capitalize()} City'
  return gym_name, location


def build_where_condition(search_terms, modifier):
  search_terms = search_terms.replace(',', ' ')
  where_clause = ''
  word_list = []
  search_words = search_terms.split()
  for word in search_words:
    word_list.append(f"{modifier} LIKE '%{word}%'")
  where_clause = ' OR '.join(word_list)
  return where_clause


def save_pokemon(poke_tuple):
  poke_list = []
  poke_attr = ('id', 'name', 'url')
  for pokemon in poke_tuple:
    it = iter(pokemon)
    keys = iter(poke_attr)
    poke_dict = dict(zip(keys, it))
    poke_list.append(poke_dict)
  return poke_list