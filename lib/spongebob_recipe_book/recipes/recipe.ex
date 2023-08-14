defmodule SpongebobRecipeBook.Recipes.Recipe do
  use Ecto.Schema
  import Ecto.Changeset

  schema "recipes" do
    field :dish, :string
    field :ingredients, :string
    field :instructions, :string
    belongs_to :user, SpongebobRecipeBook.Users.User

    timestamps()
  end

  @doc false
  def changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [:user_id, :dish, :instructions, :ingredients])
    |> validate_required([:user_id, :dish, :instructions, :ingredients])
  end
end
