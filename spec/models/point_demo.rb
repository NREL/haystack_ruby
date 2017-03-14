class PointDemo
  # these fields are required on the class point is mixed into
  attr_accessor :haystack_project_name, :haystack_point_id, :haystack_time_zone
  include HaystackRuby::Point
  def initialize(proj_name, point_id, tz)
    @haystack_project_name = proj_name
    @haystack_point_id = point_id
    @haystack_time_zone = tz
  end
end