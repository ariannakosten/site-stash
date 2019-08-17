<h1>Links by Category</h1>
<br><br>
<h2>Category List</h2>
<% if !@categories.empty? %>
  <p>Select the category title to see all of your saved links in that category:</p>
<% end %>

<ul class="spacing">
  <% @categories.each do |category| %>
    <li><a href="/categories/<%= category.id %>"><%= category.name %></a></li>
  <% end %>
</ul><br>

<% if @categories.empty? %>
  <p>You currently do not have any categories. Add a new link entry and create your category <a href="/links/new">here!</a></p>
<% end %><br>


<a href="/home">Home</a>       
<a href="/logout">Log Out</a>