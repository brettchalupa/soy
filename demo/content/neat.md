<% @title = "Neat Products Made of Soy" %>

# <%= @title %>

<% ["tofu", "tempeh", "edamame"].each do |product| %>
- <%= product %>
<% end %>
