require_relative "../config/environment.rb"

# Write methods that return SQL queries for each part of the challenge here

# Who did Jon Stewart have on the Daily Show the most?
def guest_with_most_appearances
  sql = <<-SQL
    SELECT guest_name,
    	COUNT(id) as appearance_count
    FROM guest_appearances
    GROUP BY guest_name
    ORDER BY appearance_count DESC
    LIMIT 1;
  SQL
  fg = DB[:conn].execute(sql)[0]
  puts "#{fg[0]}: #{fg[1]} appearances."
end

# What was the most popular profession of guest for each year Jon Stewart hosted the Daily Show?
def most_popular_profession_per_year
  sql = <<-SQL
    WITH mp AS (
        SELECT show_year,
          guest_occupation,
        	COUNT(id) as occupation_count
        FROM guest_appearances
        GROUP BY guest_occupation, show_year)
    SELECT show_year, guest_occupation, MAX(occupation_count) as frequency
    FROM mp
    GROUP BY show_year;
  SQL
  DB[:conn].execute(sql).each {|record| puts "#{record[0]}: #{record[1]}, #{record[2]}."}
end

# What profession was on the show most overall?
def most_popular_profession
  sql = <<-SQL
    SELECT guest_occupation,
    COUNT(id) as occupation_count
    FROM guest_appearances
    GROUP BY guest_occupation
    ORDER BY occupation_count DESC
    LIMIT 1;
  SQL
  mp = DB[:conn].execute(sql)[0]
  puts "#{mp[0]}: #{mp[1]} appearances."
end

# How many people did Jon Stewart have on with the first name of Bill?
def how_many_bills
  sql = <<-SQL
    WITH bills as (
      SELECT DISTINCT guest_name
    	FROM guest_appearances
    	WHERE guest_name LIKE "Bill %"
    )
    SELECT count(guest_name)
    FROM bills;
  SQL
  puts DB[:conn].execute(sql)[0][0]
end

# What dates did Patrick Stewart appear on the show?
def patrick_stewart_appearances
  sql = <<-SQL
    SELECT show_date
    FROM guest_appearances
    WHERE guest_name = "Patrick Stewart";
  SQL
  puts DB[:conn].execute(sql)
end

# Which year had the most guests?
def year_with_most_guests
  sql = <<-SQL
    SELECT show_year, count(id) AS guest_count
    FROM guest_appearances
    GROUP BY show_year
    ORDER BY guest_count DESC
    LIMIT 1;
  SQL
  mg = DB[:conn].execute(sql)[0]
  puts "#{mg[0]}: #{mg[1]} guests."
end

# What was the most popular "Group" for each year Jon Stewart hosted?
def most_popular_group_per_year
  sql = <<-SQL
    WITH mp AS (
        SELECT show_year,
            guest_group,
          COUNT(id) as group_count
        FROM guest_appearances
        GROUP BY guest_group, show_year)
    SELECT show_year, guest_group, MAX(group_count) as frequency
    FROM mp
    GROUP BY show_year;
  SQL
  DB[:conn].execute(sql).each {|record| puts "#{record[0]}: #{record[1]}, #{record[2]}."}
end
