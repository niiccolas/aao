require 'maze'

describe "Maze class" do
  new_maze = Maze.new(['maze1.txt'])

  describe "#initialize" do
    it "should set @maze to a two dimensional array" do
      expect(new_maze.maze[0][0]).to_not eq(nil)
    end
  end

  describe "#start_point" do
    it "should return an array" do
      expect(new_maze.start_point.is_a? Array).to eq(true)
    end

    it "should return an array of two coordinates" do
      expect(new_maze.start_point.length).to eq(2)
    end

    sp_row    = new_maze.start_point[0]
    sp_column = new_maze.start_point[1]
    it "its coordinates called on @maze should correspond to the start point 'S' marker" do
      expect(new_maze.maze[sp_row][sp_column]).to eq('S')
    end
  end
end
