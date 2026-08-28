local function find_sequence(start, prisms)
  local sequence = {}
  local x, y, angle = start.x, start.y, start.angle % 360

  while true do
    local state = {
      distance = math.huge,
      id = nil,
      x = nil,
      y = nil,
      angle = nil
    }

    for _, prism in ipairs(prisms) do
      local dx = prism.x - x
      local dy = prism.y - y

      if dx ~= 0 or dy ~= 0 then
        local angle_to_prism = math.deg(math.atan(dy, dx)) % 360

        if math.min(math.abs(angle_to_prism - angle), math.abs(angle_to_prism - angle + 360)) < 1e-2 then
          local distance = math.sqrt(dx * dx + dy * dy)

          if distance < state.distance then
            state = {
              distance = distance,
              id = prism.id,
              x = prism.x,
              y = prism.y,
              angle = (angle + prism.angle) % 360
            }
          end
        end
      end
    end

    if state.id then
      table.insert(sequence, state.id)
      x, y, angle = state.x, state.y, state.angle
    else
      return sequence
    end
  end
end

return { find_sequence = find_sequence }