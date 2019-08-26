require_relative('../db/sql_runner')

class User

  attr_accessor :name, :home_location
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @home_location = options['home_location']
  end

  def save()
    sql = "INSERT INTO users
    (
      name,
      home_location
    )
    VALUES
    (
      $1, $2
    )
    RETURNING *"
    values = [@name, @home_location]
    user_data = SqlRunner.run(sql, values)
    @id = user_data.first()['id'].to_i
  end

end
