defmodule Bamboo.EEx do
  defmacro __using__(opts) do
    quote do
      import Bamboo.Email
      import Bamboo.EEx

      @opts unquote(opts)

      @doc """
      Render an EEx template and set the body as HTML on the email.
      """
      @spec render_to_html(Bamboo.Email.t, String.t, map | list) :: Bamboo.Email.t
      def render_to_html(email, template, assigns \\ %{}) do
        email
        |> base_email(template, assigns)
        |> render_to(:html_body, @opts)
      end

      @doc """
      Render an EEx template and set the body as text on the email
      """
      @spec render_to_text(Bamboo.Email.t, String.t, map | list) :: Bamboo.Email.t
      def render_to_text(email, template, assigns \\ %{}) do
        email
        |> base_email(template, assigns)
        |> render_to(:text_body, @opts)
      end

      #
      # private
      #

      defp base_email(email, template, assigns) do
        email
        |> put_private(:template, template)
        |> assign(assigns)
      end

      defp render_template(template, assigns, opts) do
        EEx.eval_file(path_to_template(opts[:path], template), assigns, opts)
      end

      defp path_to_template(nil, template), do: template
      defp path_to_template(root, template) when is_binary(root), do: Path.join(root, template)
      defp path_to_template(_root, _template), do: raise ArgumentError, message: "Bamboo.EEx expects :path to be a string"

      defp render_to(%{ assigns: assigns, private: %{ template: template } } = email, body_type, opts) do
        assigns = Enum.into(assigns, [])

        email
        |> Map.put(body_type, render_template(template, assigns, opts))
      end
    end
  end

  @doc """
  Assigns values to an email.
  """
  @spec assign(Bamboo.Email.t, map | list) :: Bamboo.Email.t
  def assign(email, assigns) when is_list(assigns) do
    assigns = Enum.into(assigns, %{})

    assign(email, assigns)
  end
  def assign(%{ assigns: assigns_1 } = email, assigns_2) when is_map(assigns_2) do
    assigns = assigns_1 |> Map.merge(assigns_2)

    %{ email | assigns: assigns }
  end

  @doc """
  Assigns a value to a key in an email.
  """
  @spec assign(Bamboo.Email.t, atom, atom) :: Bamboo.Email.t
  def assign(%{ assigns: assigns } = email, key, value) do
    %{ email | assigns: Map.put(assigns, key, value) }
  end
end
