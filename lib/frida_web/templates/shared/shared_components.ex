defmodule FridaWeb.SharedComponents do
  def card(assigns \\ %{}, do: block), do: render_template("_card.html", assigns, block)

  defp render_template(template, assigns, block) do
    assigns =
      assigns
      |> Map.new()
      |> Map.put(:inner_content, block)

    FridaWeb.SharedView.render(template, assigns)
  end
end
