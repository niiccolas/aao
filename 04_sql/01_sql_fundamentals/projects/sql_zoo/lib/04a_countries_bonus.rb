# == Schema Information
#
# Table name: countries
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo.rb'

# BONUS QUESTIONS: These problems require knowledge of aggregate
# functions. Attempt them after completing section 05.

def highest_gdp
  # Which countries have a GDP greater than every country in Europe? (Give the
  # name only. Some countries may have NULL gdp values)
  execute(<<-SQL)
    SELECT
      countries.name
    FROM
      countries
    WHERE
      countries.gdp > (
        SELECT MAX(gdp)
        FROM   countries
        WHERE  continent = 'Europe'
      );
  SQL
end

def largest_in_continent
  # Find the largest country (by area) in each continent. Show the continent,
  # name, and area.
  execute(<<-SQL)
    SELECT DISTINCT
      countries.continent,
      countries.name,
      countries.area
    FROM
      countries
    WHERE
      area IN (
        SELECT   MAX(area)
        FROM     countries
        GROUP BY continent
      );
  SQL
end

def large_neighbors
  # Some countries have populations more than three times that of any of their
  # neighbors (in the same continent). Give the countries and continents.
  execute(<<-SQL)
    SELECT
      populous.name,
      populous.continent
    FROM
      countries AS populous
    WHERE
      populous.population > 3 * (
        SELECT MAX(sparse.population)
        FROM   countries AS sparse
        WHERE  sparse.name != populous.name AND
               sparse.continent = populous.continent
      );
  SQL
end
