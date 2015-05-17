class PointDemo
  # these fields are required on the class point is mixed into
  attr_accessor :project_name, :point_id
  include ProjectHaystack::Point
  def initialize(proj_name, point_id)
    @project_name = proj_name
    @point_id = point_id
  end
end