require_relative( '../db/sql_runner' )


class GymCourse

  attr_reader :id
  attr_accessor :course_name, :capacity, :offpeak

  def initialize(gym_course)
    @id = gym_course['id'].to_i if gym_course['id']
    @course_name = gym_course['course_name']
    @capacity = gym_course['capacity'].to_i
    @offpeak = gym_course['offpeak']
  end

  def save()
    sql = "INSERT INTO gym_courses (
      course_name,
      capacity,
      offpeak

    ) VALUES (
      $1, $2, $3
      )RETURNING id"

    values = [@course_name, @capacity, @offpeak]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM gym_courses"
    results = SqlRunner.run(sql)
    return results.map{|result| GymCourse.new(result)}
  end

  def update()
    sql = "UPDATE gym_courses SET (
      course_name,
      capacity,
      offpeak
     ) = ($1, $2, $3) WHERE id = $4"
    values = [@course_name, @capacity, @offpeak, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM gym_courses"
    SqlRunner.run(sql)
  end

  def members()
    sql = "SELECT m.* FROM members m INNER JOIN joinings j ON j.member_id = m.id WHERE j.gym_course_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |member| Member.new(member) }
  end

  def self.find(id)
    sql = "SELECT * FROM gym_courses WHERE id = $1 "
    values = [id]
    results = SqlRunner.run(sql, values)
    return GymCourse.new(results.first())
  end
end
