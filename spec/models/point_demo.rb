class PointDemo
  # these fields are required on the class point is mixed into
  attr_accessor :haystack_project_name, :haystack_point_id
  include ProjectHaystack::Point
  def initialize(proj_name, point_id)
    @haystack_project_name = proj_name
    @haystack_point_id = point_id
  end
end