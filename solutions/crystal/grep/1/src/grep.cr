module Grep
  def self.search(pattern : String, flags : Array(String), files : Array(String)) : String
    regex_pattern = pattern
    regex_flags = Regex::CompileOptions::None

    if flags.includes?("-x")
      regex_pattern = "^#{pattern}$"
    end

    if flags.includes?("-i")
      regex_flags |= Regex::CompileOptions::IGNORE_CASE
    end

    regex = Regex.new(regex_pattern, regex_flags)

    results = [] of String

    system("find .")
    system("pwd")
    system("tree")

    files.each do |file|
      File.open("assets/#{file}", "r") do |f|
        f.each_line.with_index do |line, index|
          matches = line.match(regex)
          matches = !matches if flags.includes?("-v")

          if matches
            if flags.includes?("-l")
              results << file
              break
            else
              prefix = ""
              prefix += "#{file}:" if files.size > 1
              prefix += "#{index + 1}:" if flags.includes?("-n")

              results << "#{prefix}#{line.chomp}"
            end
          end
        end
      end
    end

    results.join("\n")
  end
end