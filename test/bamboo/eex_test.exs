defmodule Bamboo.EExTest do
  use ExUnit.Case, async: true

  use Bamboo.EEx, path: "test/support"

  describe "assign/2" do
    test "merges a map into `:assigns`" do
      email =
        new_email()
        |> assign(:key, "value1")
        |> assign(%{ key: "value2" })

      assert %{ assigns: %{ key: "value2" } } = email
    end
  end

  describe "assign/3" do
    test "adds a key/value pair to `:assigns`" do
      email =
        new_email()
        |> assign(:key, "value")

      assert %{ assigns: %{ key: "value" } } = email
    end
  end

  describe "render_to_html/3" do
    test "renders email to `:html_body`" do
      email =
        new_email()
        |> render_to_html("template.eex", %{ world: "world" })

      assert %{ html_body: "Hello world\n" } = email
    end
  end

  describe "render_to_text/3" do
    test "renders email to `:text_body`" do
      email =
        new_email()
        |> render_to_text("template.eex", %{ world: "world" })

      assert %{ text_body: "Hello world\n" } = email
    end
  end
end
