colors = {'black', 'brown', 'red', 'orange', 'yellow', 'green', 'blue', 'violet', 'grey', 'white'}
map = { c, i - 1 for i, c in ipairs colors }

{
  color_code: (color) -> map[color]
  colors: -> colors
}