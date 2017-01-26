#this file create a connection to db and load users and hintIDs to hash maps

require 'mysql2'
require './user'
require './condb'

#connect to db


#load students into hash map

def set_students_hash_map
  connect_db
  load_users = $dbcon.query('SELECT * FROM users')
  #clear hah and update data to student hash map from db
  USERS_HASH_MAP.clear
  load_users.each do |user|
    USERS_HASH_MAP[user['email']] = User.new(user['name'], user['email'], user['passwd'], user['hintID'], user['hintAnswer'])
  end
end

def remove(email)
  $dbcon.query("DELETE FROM users WHERE email = '"+email+"' LIMIT 1");
end

#load hint into hash map
def set_hints_hash_map
  load_hints = $dbcon.query('SELECT * FROM hints')

  i = 1
  load_hints.each do |hint|
    HINTS_HASH_MAP[i] = hint['hint']
    i = i + 1
  end
end

def save_to_db(name,email,passwd,hintID,hintAnswer)

  $dbcon.query("INSERT INTO users (name, email, passwd, hintID, hintAnswer) VALUES ('#{name}', '#{email}', '#{passwd}', '#{hintID}', '#{hintAnswer}')")
end

def change_pass(email,new_pass)
  $dbcon.query("UPDATE users SET users.passwd=#{new_pass} WHERE users.email='#{email}';")
end