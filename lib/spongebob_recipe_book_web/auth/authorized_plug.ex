defmodule SpongebobRecipeBookWeb.Auth.AuthorizedPlug do
  alias SpongebobRecipeBookWeb.Auth.ErrorResponse

  def is_authorized(%{params: %{"user" => params}} = conn, _opts) do

    if conn.assigns.user.id == params["id"] do
      conn
    else
      raise ErrorResponse.Forbidden
    end
  end

  def is_authorized(%{params: %{"recipe" => params}} = conn, _opts) do

    if Enum.any?(conn.assigns.user.recipes, fn recipe -> recipe.id == params["id"] end) do
      conn
    else
      raise ErrorResponse.Forbidden
    end
  end
end
