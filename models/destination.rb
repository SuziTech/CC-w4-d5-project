require_relative('../db/sql_runner')

class Destination

  attr_accessor :name, :location, :priority, :reason_to_go, :travel_method, :visited_or_not
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @location = options['location']
    @priority = options['priority']
    @reason_to_go = options['reason_to_go']
    @travel_method = options['travel_method']
    @visited_or_not = options['visited_or_not']
  end

  def save()
    sql = "INSERT INTO destinations
    (
      name,
      location,
      priority,
      reason_to_go,
      travel_method,
      visited_or_not
    )
    VALUES
    (
      $1, $2, $3, $4, $5, $6
    )
    RETURNING *"
    values = [@name, @location, @priority, @reason_to_go, @travel_method, @visited_or_not]
    destination_data = SqlRunner.run(sql, values)
    @id = destination_data.first()['id'].to_i
  end

  def update()
    sql = "UPDATE destinations
    SET
    (
      name,
      location,
      priority,
      reason_to_go,
      travel_method,
      visited_or_not
    ) =
    (
      $1, $2, $3, $4, $5, $6
    )
    WHERE id = $7"
    values = [@name, @location, @priority, @reason_to_go, @travel_method, @visited_or_not, @id]
    SqlRunner.run( sql, values )
  end

  def delete()
    sql = "DELETE FROM destinations
    WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def self.all()
    sql = "SELECT * FROM destinations"
    destination_data = SqlRunner.run( sql )
    result = destination_data.map { |destination_datum| Destination.new( destination_datum ) }
    return result
  end

  def self.find( id )
    sql = "SELECT * FROM destinations
    WHERE id = $1"
    values = [id]
    destination_datum = SqlRunner.run( sql, values )
    result = Destination.new( destination_datum.first )
    return result
  end

  def self.fuzzy_search( string )
    sql = "SELECT * FROM destinations
    WHERE name LIKE '%#{string}%'
    OR location LIKE '%#{string}%';"
    # values = [string]
    destination_data = SqlRunner.run( sql)
    result = destination_data.map { |destination_datum| Destination.new( destination_datum) }
    return result
  end

end
