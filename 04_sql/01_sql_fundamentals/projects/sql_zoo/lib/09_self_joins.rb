# == Schema Information
#
# Table name: stops
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: routes
#
#  num         :string       not null, primary key
#  company     :string       not null, primary key
#  pos         :integer      not null, primary key
#  stop_id     :integer

require_relative './sqlzoo.rb'

def num_stops
  # How many stops are in the database?
  execute(<<-SQL)
    SELECT
      COUNT(name)
    FROM
      stops;
  SQL
end

def craiglockhart_id
  # Find the id value for the stop 'Craiglockhart'.
  execute(<<-SQL)
    SELECT DISTINCT
      stops.id
    FROM
      stops
    WHERE
      stops.name = 'Craiglockhart';
  SQL
end

def lrt_stops
  # Give the id and the name for the stops on the '4' 'LRT' service.
  execute(<<-SQL)
    SELECT DISTINCT
      routes.stop_id,
      stops.name
    FROM
      stops
    JOIN
      routes ON routes.stop_id = stops.id
    WHERE
      routes.company = 'LRT' AND
      routes.num = '4';
  SQL
end

def connecting_routes
  # Consider the following query:
  #
  # SELECT
  #   company,
  #   num,
  #   COUNT(*)
  # FROM
  #   routes
  # WHERE
  #   stop_id = 149 OR stop_id = 53
  # GROUP BY
  #   company, num
  #
  # The query gives the number of routes that visit either London Road
  # (149) or Craiglockhart (53). Run the query and notice the two services
  # that link these stops have a count of 2. Add a HAVING clause to restrict
  # the output to these two routes.
  execute(<<-SQL)
  SELECT
    company,
    num,
    COUNT(*)
  FROM
    routes
  WHERE
    stop_id = 149 OR stop_id = 53
  GROUP BY
    company, num
  HAVING
    COUNT(*) = 2;
  SQL
end

def cl_to_lr
  # Consider the query:
  #
  # SELECT
  #   a.company,
  #   a.num,
  #   a.stop_id,
  #   b.stop_id
  # FROM
  #   routes a
  # JOIN
  #   routes b ON (a.company = b.company AND a.num = b.num)
  # WHERE
  #   a.stop_id = 53
  #
  # Observe that b.stop_id gives all the places you can get to from
  # Craiglockhart, without changing routes. Change the query so that it
  # shows the services from Craiglockhart to London Road. (149)
  execute(<<-SQL)
  SELECT
    a.company,
    a.num,
    a.stop_id,
    b.stop_id
  FROM
    routes a
  JOIN
    routes b ON (a.company = b.company AND a.num = b.num)
  WHERE
    a.stop_id = 53 AND
    b.stop_id = 149;
  SQL
end

def cl_to_lr_by_name
  # Consider the query:
  #
  # SELECT
  #   a.company,
  #   a.num,
  #   stopa.name,
  #   stopb.name
  # FROM
  #   routes a
  # JOIN
  #   routes b ON (a.company = b.company AND a.num = b.num)
  # JOIN
  #   stops stopa ON (a.stop_id = stopa.id)
  # JOIN
  #   stops stopb ON (b.stop_id = stopb.id)
  # WHERE
  #   stopa.name = 'Craiglockhart'
  #
  # The query shown is similar to the previous one, however by joining two
  # copies of the stops table we can refer to stops by name rather than by
  # number. Change the query so that the services between 'Craiglockhart' and
  # 'London Road' are shown.
  execute(<<-SQL)
    SELECT
      a.company,
      a.num,
      stopa.name,
      stopb.name
    FROM
      routes a
    JOIN
      routes b ON (a.company = b.company  AND a.num = b.num)
    JOIN
      stops stopa ON (a.stop_id = stopa.id)
    JOIN
      stops stopb ON (b.stop_id = stopb.id)
    WHERE
      stopa.name = 'Craiglockhart' AND
      stopb.name = 'London Road';
  SQL
end

def haymarket_and_leith
  # Give the company and num of the services that connect stops
  # 115 and 137 ('Haymarket' and 'Leith')
  execute(<<-SQL)
    SELECT DISTINCT
      a.company,
      a.num
    FROM
      routes a
    JOIN
      routes b ON (a.company = b.company    AND   a.num = b.num)
    JOIN
      stops stopa ON (a.stop_id = stopa.id)
    JOIN
      stops stopb ON (b.stop_id = stopb.id)
    WHERE
      stopa.name = 'Haymarket' AND
      stopb.name = 'Leith';
  SQL
end

def craiglockhart_and_tollcross
  # Give the company and num of the services that connect stops
  # 'Craiglockhart' and 'Tollcross'
  execute(<<-SQL)
    SELECT
      a.company,
      a.num
    FROM
      routes a
    JOIN
      routes b ON (a.company = b.company AND a.num = b.num)
    JOIN
      stops stopA ON (a.stop_id = stopA.id)
    JOIN
      stops stopB ON (b.stop_id = stopB.id)
    WHERE
      stopA.name = 'Craiglockhart' AND
      stopB.name = 'Tollcross';
  SQL
end

def start_at_craiglockhart
  # Give a distinct list of the stops that can be reached from 'Craiglockhart'
  # by taking one bus, including 'Craiglockhart' itself. Include the stop name,
  # as well as the company and bus no. of the relevant service.
  execute(<<-SQL)
    SELECT
      arrival_stops.name,
      arrival.company,
      arrival.num
    FROM
      routes AS departure
    JOIN
      routes AS arrival ON (departure.company = arrival.company AND departure.num = arrival.num)
    JOIN
      stops AS arrival_stops ON (arrival.stop_id = arrival_stops.id)
    JOIN
      stops AS departure_stops ON (departure_stops.id = departure.stop_id)
    WHERE
      departure_stops.name = 'Craiglockhart';
  SQL
end

def craiglockhart_to_sighthill
  # Find the routes involving two buses that can go from Craiglockhart to
  # Sighthill. Show the bus no. and company for the first bus, the name of the
  # stop for the transfer, and the bus no. and company for the second bus.
  execute(<<-SQL)
    SELECT DISTINCT
      first_bus.num,
      first_bus.company,
      junction.name,
      last_bus.num,
      last_bus.company
    FROM
      routes first_bus
    JOIN
      routes AS to_junction ON (first_bus.company = to_junction.company AND first_bus.num = to_junction.num)
    JOIN
      stops  AS junction ON (to_junction.stop_id = junction.id)
    JOIN
      routes AS from_junction ON junction.id = from_junction.stop_id
    JOIN
      routes AS last_bus ON from_junction.company = last_bus.company AND from_junction.num = last_bus.num
    JOIN
      stops  AS from_stops ON first_bus.stop_id = from_stops.id
    JOIN
      stops  AS to_stops ON last_bus.stop_id = to_stops.id
    WHERE
      from_stops.name = 'Craiglockhart' AND
      to_stops.name = 'Sighthill';
  SQL
end
