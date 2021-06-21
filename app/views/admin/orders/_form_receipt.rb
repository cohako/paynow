<%= form_with url: url, model: ([:admin,receipt]) do |f| %>
  <p><%= f.label :payment_date %></p>
  <p><%= f.date_field :payment_date %></p>
  <p><%= f.label :auth_code %></p>
  <p><%= f.text_field :auth_code %></p>
  <p><%= f.submit "Cadastar Pagamento" %></p>
<% end %>