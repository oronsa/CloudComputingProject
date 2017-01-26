require './user'

$curr_user = nil

VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]{2,}\z/
VALID_PASSWORD_REGEX = /[a-zA-Z0-9_~!@$%^&*()]{6,}/

def register_user(name,passwd, email)
  if !valid_regex(email,passwd)
    return erb :message, :locals => { :message => 'Wrong details,register process fails!' }
  end

#check if exist
  if check_if_exist(email)
    return  erb :message, :locals => { :message => 'Wrong details, user already exist!' }
  end

  $curr_user = User.new(name, email, passwd, nil, nil)

#until now we created a new user and now we moving on to choose a hint
  res = ''
  HINTS_HASH_MAP.each do |hint|
    res << "<option value=" + hint[0].to_s + ">" + hint[1] + "</option>"
  end
  erb :hints, :locals => { :message => res }

end

def valid_regex(email, passwd)
  if !(VALID_EMAIL_REGEX.match(email)) || !(VALID_PASSWORD_REGEX.match(passwd))
    return false
  end
  else
    return true
end

def check_if_exist(email)
  if USERS_HASH_MAP.key?(email)
    return true
  end
  false
end


def update_user_hints(hintID, hintAnswer)
  $curr_user.hintID=hintID
  $curr_user.hintAnswer=hintAnswer
end

def save_user
  if $curr_user != nil
    $curr_user.save_new_user
  end
end