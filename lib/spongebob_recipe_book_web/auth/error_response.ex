defmodule SpongebobRecipeBookWeb.Auth.ErrorResponse.Unauthorized do
  defexception [message: "Unauthorized", plug_status: 401]
end

defmodule SpongebobRecipeBookWeb.Auth.ErrorResponse.Forbidden do
  defexception [message: "You do not have access to this resource", plug_status: 403]
end

defmodule SpongebobRecipeBookWeb.Auth.ErrorResponse.NotFound do
  defexception [message: "Not found", plug_status: 404]
end
