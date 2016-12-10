input = %w[L1 L5 R1 R3 L4 L5 R5 R1 L2 L2 L3 R4 L2 R3 R1 L2 R5 R3 L4 R4 L3 R3 R3 L2 R1 L3 R2 L1 R4 L2 R4 L4 R5 L3 R1 R1 L1 L3 L2 R1 R3 R2 L1 R4 L4 R2 L189 L4 R5 R3 L1 R47 R4 R1 R3 L3 L3 L2 R70 L1 R4 R185 R5 L4 L5 R4 L1 L4 R5 L3 R2 R3 L5 L3 R5 L1 R5 L4 R1 R2 L2 L5 L2 R4 L3 R5 R1 L5 L4 L3 R4 L3 L4 L1 L5 L5 R5 L5 L2 L1 L2 L4 L1 L2 R3 R1 R1 L2 L5 R2 L3 L5 L4 L2 L1 L2 R3 L1 L4 R3 R3 L2 R5 L1 L3 L3 L3 L5 R5 R1 R2 L3 L2 R4 R1 R1 R3 R4 R3 L3 R3 L5 R2 L2 R4 R5 L4 L3 L1 L5 L1 R1 R2 L1 R3 R4 R5 R2 R3 L2 L1 L5]

DIRECTION_MAP = {
  north: {
    R: :east,
    L: :west
  },
  east: {
    R: :south,
    L: :north
  },
  south: {
    R: :west,
    L: :east
  },
  west: {
    R: :north,
    L: :south
  }
}

x = 0
y = 0
heading = :north
destinations = [[0, 0]]
index = nil
#puts "-> heading: #{heading} x: #{x}, y: #{y}"
duplicate = nil

input.each_with_index do |val, i|
  distance = val[1..-1].to_i
  heading = DIRECTION_MAP.fetch(heading).fetch(val[0].to_sym)
  distance.times do |d|
    case heading
    when :north
      then y += 1
    when :east
      then x += 1
    when :south
      then y -= 1
    when :west
      then x -= 1
    end
    destinations << [x, y]
    duplicate = destinations.group_by{|e| e}.select{|k, v| v.size > 1}
    unless duplicate.empty?
      index = destinations.index([x, y])
      #puts "destination found at index: #{index}"
      #puts "cmd: #{val} -> heading: #{heading}, x: #{x}, y: #{y}, iter: #{i}"

      break
    end
    #puts "cmd: #{val} -> heading: #{heading}, x: #{x}, y: #{y}, iter: #{i}"
  end
  break unless duplicate.empty?
end

puts "total blocks: #{x.abs + y.abs}"
