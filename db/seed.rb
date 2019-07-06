# Parse the CSV and seed the database here! Run 'ruby db/seed' to execute this code.

require_relative "../config/environment.rb"
require 'csv'

# Create database

rows = DB[:conn].execute <<-SQL
    CREATE TABLE guest_appearances (
      id INTEGER PRIMARY KEY,
      show_year INTEGER,
      guest_occupation STRING,
      show_date STRING,
      guest_group STRING,
      guest_name STRING
    );
  SQL

# Insert rows from CSV

sql = <<-SQL
  INSERT INTO guest_appearances (show_year,guest_occupation,show_date,guest_group,guest_name)
  VALUES (?, ?, ?, ?, ?)
SQL
CSV.foreach("daily_show_guests.csv", headers: true) do |row|
  DB[:conn].execute(sql,row.fields)
end
