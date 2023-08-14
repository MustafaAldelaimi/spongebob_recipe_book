defmodule SpongebobRecipeBook.Repo do
  use Ecto.Repo,
    otp_app: :spongebob_recipe_book,
    adapter: Ecto.Adapters.Postgres
end
