defmodule SpongebobRecipeBook.Repo.Migrations.CreateRecipes do
  use Ecto.Migration

  def change do
    create table(:recipes) do
      add :dish, :string
      add :instructions, :string
      add :ingredients, :string
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:recipes, [:user_id])
    create unique_index(:recipes, [:dish])
  end
end
