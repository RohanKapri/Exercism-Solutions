class Prism
  @findSequence: (start, prisms) ->
    {x, y, angle} = start
    sequence = []

    loop
      rad = angle * Math.PI / 180
      dirX = Math.cos(rad)
      dirY = Math.sin(rad)

      nearest = null
      nearestDist = Infinity

      for prism in prisms
        dx = prism.x - x
        dy = prism.y - y

        # Distance along the ray
        dist = dx * dirX + dy * dirY
        continue unless dist > 1e-6

        # Squared perpendicular distance to the ray
        crossSq =
          (dx - dist * dirX) * (dx - dist * dirX) +
          (dy - dist * dirY) * (dy - dist * dirY)

        # Allow a small relative tolerance
        continue unless crossSq < 1e-6 * Math.max(1, dist * dist)

        if dist < nearestDist
          nearestDist = dist
          nearest = prism

      break unless nearest

      sequence.push nearest.id

      x = nearest.x
      y = nearest.y
      angle = (angle + nearest.angle) % 360

    sequence

module.exports = Prism