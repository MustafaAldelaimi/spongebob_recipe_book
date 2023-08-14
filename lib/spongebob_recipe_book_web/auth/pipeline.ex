defmodule SpongebobRecipeBookWeb.Auth.Pipeline do

  use Guardian.Plug.Pipeline, otp_app: :spongebob_recipe_book,
  module: SpongebobRecipeBookWeb.Auth.Guardian,
  error_handler: SpongebobRecipeBookWeb.Auth.GuardianErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
