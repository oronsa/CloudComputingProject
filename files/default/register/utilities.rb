require './database'
require './user'

def show_all
  users_list = USERS_HASH_MAP.values

  users_list_view = '<ul>'
  users_list.each do |user|
    users_list_view += '<li style="color:blue;"><span>' + user.to_s + '</li>'
  end
  users_list_view += '</ul>'
  erb :showAll, :locals => { :message => users_list_view }
end

def remove_user(email,passwd)
  if check_details(email,passwd)
    remove(email)
    return erb :message, :locals => { :message => 'The user was removed successfully!' }
  end
  else
    return erb :message, :locals => { :message => 'Please try again!' }
end

def log_in_user(email,passwd)
  if check_details(email,passwd)
    return erb :message, :locals => { :message => 'Welcome back my friend!' }
  end
else
  return erb :message, :locals => { :message => 'please try again!' }
end

def recover_pass(email,new_password)
    if change_password(email,new_password)
      return erb :message, :locals => { :message => 'Your password has been recovered!' }
    end
else
  return erb :message, :locals => { :message => 'Recover failed!!!' }

end

def check_details(email,password)
  flag = false
  users_list = USERS_HASH_MAP.values
  users_list.each do |row|
    if email == row.email && password == row.passwd
      flag =true
    end
  end
  flag
end

def change_password(email,new_password)
  flag = false
  users_list = USERS_HASH_MAP.values
  users_list.each do |row|
    if email == row.email
      change_pass(email,new_password)
      flag = true
    end
  end
  flag
end
