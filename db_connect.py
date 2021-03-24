"""
author:         Sandro Aguilar and Kuljot Biring
module name:    db_connect
purpose:        this module has various functions that connects to a MySQL
                database and executes various queries. This module also
                imports another module holding my database credentials.
"""
import mysql.connector
from db_credentials import host, user, password, db


#-------------------------------------------------------------------------
# Function name:            connect_db()
# Description:              connects to the database using the supplied DB
#                           data and returns the connection
#-------------------------------------------------------------------------
def connect_db():
  mydb = mysql.connector.connect(
      host = host,
      user = user,
      password = password,
      db = db
  )
  # verify connection to DB
  # print(mydb)

  # return DB connection
  return mydb


#-------------------------------------------------------------------------
# Function name:            create_database()
# Description:              checks if a database exists and creates a new
#                           one if not.
#-------------------------------------------------------------------------
def create_database():
  mydb = mysql.connector.connect(
    host = host,
    user = user,
    password = password
  )
  # return DB connection
  return mydb


#-------------------------------------------------------------------------
# Function name:            execute_db_query(db_con, query)
# Description:              executes a database query using the given
#                           parameters.
#-------------------------------------------------------------------------
def execute_db_query(conn, query, query_args = ()):
  print("> executing an SQL query >>>>>>>>>>>>>>>>>>")

  # create cursor
  mycursor = conn.cursor()

  # execute query
  mycursor.execute(query, query_args)

  # return results of executed query
  # results = mycursor.fetchall()

  # commit changes to database
  # conn.commit()

  # return results
  return mycursor