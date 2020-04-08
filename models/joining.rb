require_relative( '../db/sql_runner' )

class Joining

  attr_reader :id
  attr_accessor :member_id, :gym_course_id

  def initialize(joining)
    @id = joining['id'].to_i if joining['id']
    @member_id = joining['member_id'].to_i
    @gym_course_id = joining['gym_course_id'].to_i
  end

  def save()
    sql = "INSERT INTO joinings (
    member_id,
    gym_course_id
    )
    VALUES(
      $1, $2
    )RETURNING id"

    values = [@member_id, @gym_course_id]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i


  end

  def self.all()
    sql = "SELECT * FROM joinings"
    results = SqlRunner.run(sql)
    return results.map{|result| Joining.new(result)}
  end

  def update()
    sql = "UPDATE joinings SET (
    member_id,
    gym_course_id
     ) = ($1, $2) WHERE id = $3"
    values = [@member_id, @gym_course_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM joinings"
    SqlRunner.run(sql)
  end

  def member()
    sql = "SELECT * FROM members WHERE id = $1 "
    values = [@member_id]
    result = SqlRunner.run(sql, values)
    return Member.new(result.first)
  end

  def gym_course()
    sql = "SELECT * FROM gym_courses WHERE id = $1 "
    values = [@gym_course_id]
    result = SqlRunner.run(sql, values)
    return GymCourse.new(result.first)
  end

  def self.member_per_course(course_id)
    sql = "SELECT members.* FROM members INNER JOIN joinings
    ON joinings.member_id = members.id WHERE gym_course_id = $1 "
    values = [course_id]
    result = SqlRunner.run(sql, values)
    return result.map{|member| Member.new(member)}
  end

  def self.destroy(id)
    sql = "DELETE FROM joinings WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end
end
