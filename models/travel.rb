require_relative('../db/sql_runner')

class Travel

  attr_accessor :travel_date, :destination_id, :user_id
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @travel_date = options['travel_date']
    @destination_id = options['destination_id'].to_i
    @user_id = options['user_id'].to_i
  end

  def save()
    sql = "INSERT INTO travels
    (
      travel_date,
      destination_id,
      user_id
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING *"
    values = [@travel_date, @destination_id, @user_id]
    travel_data = SqlRunner.run(sql, values)
    @id = travel_data.first()['id'].to_i
  end

  def update()
    sql = "UPDATE travels
    SET
    (
      travel_date,
      destination_id,
      user_id
    ) =
    (
      $1, $2, $3
    )
    WHERE id = $4"
    values = [@travel_date, @destination_id, @user_id]
    SqlRunner.run( sql, values )
  end

  def delete()
    sql = "DELETE FROM travels
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def self.all()
    sql = "SELECT * FROM travels"
    travel_data = SqlRunner.run( sql )
    result = travel_data.map { |travel_datum| Travel.new( travel_datum ) }
    return result
  end

  def self.find( id )
    sql = "SELECT * FROM travels
    WHERE id = $1"
    values = [id]
    travel_datum = SqlRunner.run( sql, values )
    result = Travel.new( travel_datum.first )
    return result
  end


end
