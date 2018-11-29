require_relative './maze.rb'

if ARGV.empty?
  puts "Usage:\n  ruby solve_maze.rb maze_filename.txt"
elsif ARGV[0] !~ /.(txt|TXT)/
  puts 'File format not supported, use *.txt only'
else
  Maze.new(ARGV).run_maze_solver
end
