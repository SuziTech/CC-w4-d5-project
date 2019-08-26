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


end
