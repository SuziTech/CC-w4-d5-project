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


end
