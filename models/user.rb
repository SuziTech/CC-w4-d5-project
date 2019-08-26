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

  def update()
    sql = "UPDATE users
    SET
    (
      name,
      home_location
    ) =
    (
      $1, $2
    )
    WHERE id = $3"
    values = [@name, @home_location, @id]
    SqlRunner.run( sql, values )
  end

  def delete()
    sql = "DELETE FROM users
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def self.all()
    sql = "SELECT * FROM users"
    user_data = SqlRunner.run( sql )
    result = user_data.map { |user_datum| User.new( user_datum ) }
    return result
  end

  def self.find( id )
    sql = "SELECT * FROM users
    WHERE id = $1"
    values = [id]
    user_datum = SqlRunner.run( sql, values )
    result = User.new( user_datum.first )
    return result
  end

end
