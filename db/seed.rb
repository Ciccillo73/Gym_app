require_relative('../models/member')
require_relative('../models/gym_course')
require_relative('../models/joining')
require("pry-byebug")


Joining.delete_all()
GymCourse.delete_all()
Member.delete_all()

member1 = Member.new({
  "name" => "John",
  "surname" => "Phillip",
  "premium" => true
})

member1.save()

member2 = Member.new({
  "name" => "Stuart",
  "surname" => "Kilby",
  "premium" => false
})

member2.save()

member3 = Member.new({
  "name" => "Henry",
  "surname" => "McKillop",
  "premium" => false
})

member3.save()

member4 = Member.new({
  "name" => "Anthony",
  "surname" => "Toll",
  "premium" => true
})

member4.save()

gym_course1 = GymCourse.new({
  "course_name" => "Yoga",
  "capacity" => 30,
  "off_peak" => true
  })
gym_course1.save()

gym_course2 = GymCourse.new({
  "course_name" => "Pilates",
  "capacity" => 35,
  "off_peak" => true
  })
gym_course2.save()

gym_course3 = GymCourse.new({
  "course_name" => "Body Pump",
  "capacity" => 30,
  "off_peak" => false
  })
gym_course3.save()

gym_course4= GymCourse.new({
  "course_name" => "Fit Boxe",
  "capacity" => 40,
  "off_peak" => true
  })
gym_course4.save()


joining1 = Joining.new ({
  "member_id" => member1.id,
  "gym_course_id" => gym_course1.id
  })

joining1.save()

joining2 = Joining.new ({
  "member_id" => member2.id,
  "gym_course_id" => gym_course2.id
  })

joining2.save()

joining3 = Joining.new ({
  "member_id" => member3.id,
  "gym_course_id" => gym_course3.id
  })

joining3.save()

joining4 = Joining.new ({
  "member_id" => member4.id,
  "gym_course_id" => gym_course4.id
  })

joining4.save()

binding.pry
nil
