require 'sinatra'
require 'sqlite3'
require 'erb'

set :database, { adapter: 'sqlite3', database: 'users.db' }

get '/' do
  erb :index
end

post '/query' do
  query = params['query']
  @result = []

  if query && !query.empty?
    begin
      db = settings.database
      @result = db.execute(query)
    rescue SQLite3::Exception => e
      @error = e.message
    ensure
      db.close if db
    end
  end

  erb :result
end

__END__

@@layout
<!DOCTYPE html>
<html>
<head>
  <title>Database Administration</title>
</head>
<body>
  <h1>Database Administration</h1>
  <form action="/query" method="POST">
    <label for="query">Database Query:</label>
    <textarea id="query" name="query" rows="4" cols="50"></textarea>
    <br>
    <input type="submit" value="Execute Query">
  </form>
  <%= yield %>
</body>
</html>

@@index
<p>Enter your SQL query above and click "Execute Query."</p>

@@result
<table border="1">
  <tr>
    <% @result.first.each do |column| %>
      <th><%= column[0] %></th>
    <% end %>
  </tr>
  <% @result.each do |row| %>
    <tr>
      <% row.each do |column| %>
        <td><%= column[1] %></td>
      <% end %>
    </tr>
  <% end %>
</table>
