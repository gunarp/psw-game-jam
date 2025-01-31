class_name FacingHelpers
enum FACING {
  LEFT, RIGHT, NEUTRAL, DOWN
}


static func get_facing_direction(_dir: Vector2) -> FacingHelpers.FACING:
  if (_dir.length() == 0):
    return FacingHelpers.FACING.NEUTRAL

  # Approach - rotate vector into a new coordinate system
  # and just use the x and y components to deduce which direction we are facing
  # avoids dealing with too many floating point operations + perciion
  var rotated_direction = _dir.rotated(PI / 4)

  # This is a pretty verbose way of tackling this problem,
  # but I think it covers scenarios that would otherwise slip through the cracks
  # Special case - direction is a unit vector of our new coordinate system.
  if (rotated_direction.x == 0):
    # Unit vector on y-axis
    if (rotated_direction.y > 0):
      return FACING.DOWN
    else:
      return FACING.LEFT
  elif (rotated_direction.y == 0):
    # Unit vector on x-axis
    if (rotated_direction.x > 0):
      return FACING.RIGHT
    else:
      return FACING.DOWN
  else:
    # "General" case
    if (rotated_direction.x > 0 and rotated_direction.y > 0):
      return FACING.RIGHT
    elif (rotated_direction.x < 0 and rotated_direction.y > 0):
      return FACING.DOWN
    elif (rotated_direction.x < 0 and rotated_direction.y < 0):
      return FACING.LEFT
    elif (rotated_direction.x > 0 and rotated_direction.y < 0):
      return FACING.NEUTRAL

  # Unreachable
  return FACING.NEUTRAL
