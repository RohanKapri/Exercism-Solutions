class RelativeDistance
  def initialize(@family_tree : Hash(String, Array(String))); end

  def degree_of_separation(person_a, person_b)
    by_child = ->(ft : Hash(String, Array(String))) {
      inverse = Hash(String, Array(String)).new { |h, k| h[k] = [] of String }

      ft.each do |parent, children|
        children.each do |child|
          inverse[child] << parent
        end
      end

      inverse
    }

    ancestry = ->(by_child_map : Hash(String, Array(String)), name : String) {
      result = Hash(String, Int32).new

      populate_ancestry(result, by_child_map, name, 0)
    }

    child_map = by_child.call(@family_tree)
    ancestry_a = ancestry.call(child_map, person_a)
    ancestry_b = ancestry.call(child_map, person_b)

    minimum_degrees = nil

    ancestry_a.each do |parent, _|
      if ancestry_b.has_key?(parent)
        degrees = ancestry_a[parent] + ancestry_b[parent]

        if parent != person_a && parent != person_b
          degrees -= 1
        end

        if minimum_degrees.nil? || degrees < minimum_degrees
          minimum_degrees = degrees
        end
      end
    end

    minimum_degrees
  end

  private def populate_ancestry(
    ancestry_map : Hash(String, Int32),
    by_child_map : Hash(String, Array(String)),
    current_name : String,
    count : Int32,
  ) : Hash(String, Int32)
    ancestry_map[current_name] = count
    parents = by_child_map[current_name]?

    if parents
      parents.each do |parent|
        populate_ancestry(ancestry_map, by_child_map, parent, count + 1)
      end
    end

    ancestry_map
  end
end