require_relative('../db/sql_runner')

class Experience

  attr_accessor :name, :description, :destination_id
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @description = options['description']
    @destination_id = options['destination_id'].to_i
  end

  def save()
    sql = "INSERT INTO experiences
    (
      name,
      description,
      destination_id
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING *"
    values = [@name, @description, @destination_id]
    experience_data = SqlRunner.run(sql, values)
    @id = experience_data.first()['id'].to_i
  end

  def update()
    sql = "UPDATE experiences
    SET
    (
      name,
      description,
      destination_id
    ) =
    (
      $1, $2, $3
    )
    WHERE id = $4"
    values = [@name, @description, @destination_id]
    SqlRunner.run( sql, values )
  end

  def delete()
    sql = "DELETE FROM experiences
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def self.all()
    sql = "SELECT * FROM experiences"
    experience_data = SqlRunner.run( sql )
    result = experience_data.map { |experience_datum| Experience.new( experience_datum ) }
    return result
  end

  def self.find( id )
    sql = "SELECT * FROM experiences
    WHERE id = $1"
    values = [id]
    experience_datum = SqlRunner.run( sql, values )
    result = Experience.new( experience_datum.first )
    return result
  end

end
