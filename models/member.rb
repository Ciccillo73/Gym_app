require_relative( '../db/sql_runner' )

class Member
  attr_reader :id
  attr_accessor :name, :surname, :premium

  def initialize(member)
    @id = member['id'].to_i if member['id']
    @name = member['name']
    @surname = member['surname']
    @premium = member['premium']
  end

  def save()
    sql = "INSERT INTO members
    (
      name,
      surname,
      premium
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@name, @surname, @premium]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM members"
    results = SqlRunner.run(sql)
    return results.map{|result| Member.new(result)}
  end

  def update()
    sql = "UPDATE members SET (
      name,
      surname,
      premium
    ) = ($1, $2, $3) WHERE id = $4"
    values = [@name, @surname, @premium, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM members"
    SqlRunner.run(sql)
  end

  def gym_courses()
    sql = "SELECT g.* FROM gym_courses g INNER JOIN joinings j ON j.gym_course_id = g.id WHERE j.member_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |gym_course| GymCourse.new(gym_course) }
  end

  def self.find(id)
    sql = "SELECT * FROM members WHERE id = $1 "
    values = [id]
    results = SqlRunner.run(sql, values)
    return Member.new(results.first())
  end

end
