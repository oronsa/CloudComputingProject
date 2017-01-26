
class User
  attr_accessor :name, :email, :passwd, :hintID, :hintAnswer
  # @name, @email, @passwd, @hintID, @hintIDAnswer

  def initialize(name, email, passwd, hintID, hintAnswer)
    @name = name
    @email = email
    @passwd = passwd
    @hintID = hintID
    @hintAnswer = hintAnswer
  end

  def to_s
     @name.to_s + ' ' + @email.to_s + ' ' + @passwd.to_s + ' ' + @hintID.to_s + ' ' + @hintAnswer.to_s
  end

  def print_data
     printf("%-20s %-20s %-20s %-20s %-20s\n", @name, @email, @passwd, @hintID, @hintAnswer)
  end

  def save_new_user
    USERS_HASH_MAP[@email] = self
    save_to_db(@name,@email,@passwd,@hintID,@hintAnswer)
  end
end

