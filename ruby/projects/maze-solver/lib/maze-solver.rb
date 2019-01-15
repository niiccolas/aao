require_relative 'astar'

if ARGV.empty?
  puts "Usage:\n  ruby maze-solver.rb maze-file.txt"
elsif File.file?(ARGV[0])
  AStar.new(Maze.new(ARGV[0])).solve
else
  valid_files = Dir['*.txt'].sort.join(' | ')
  puts "File unknown, try:\n"
  puts "  #{valid_files}"
end
