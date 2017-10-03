# Bamboo.EEx

[![Build Status](https://travis-ci.org/sticksnleaves/bamboo_eex.svg?branch=master)](https://travis-ci.org/sticksnleaves/bamboo_eex)

No Phoenix? No problem!

Use `Bamboo.EEx` to add EEx template support to Bamboo.

## Installation

```elixir
def deps do
  [
    {:bamboo_eex, "~> 0.1.0"}
  ]
end
```

## Examples

```elixir
defmodule MyApp.Email do
  use Bamboo.EEx, path: "lib/my_app/views"

  def text_and_html_email() do
    new_email()
    |> render_to_html("email.html.eex")
    |> render_to_text("email.text.eex")
  end

  def email_with_assigns(user) do
    new_email()
    |> render_to_html("email.html.eex", user: user)
  end

  def email_with_already_assigned_user(user) do
    new_email()
    |> assign(:user, user)
    |> render_to_html("email.html.eex")
  end
end
```

## Options

When declaring `use Bamboo.EEx` you can pass in any option that EEx supports.

Consult the [EEx documentation](https://hexdocs.pm/eex/EEx.html#module-options)
for additional details on available options.

### Additional Options

`:path` - the root directory used to find EEx templates
