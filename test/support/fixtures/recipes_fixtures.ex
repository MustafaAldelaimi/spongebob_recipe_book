defmodule SpongebobRecipeBook.RecipesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SpongebobRecipeBook.Recipes` context.
  """

  @doc """
  Generate a recipe.
  """
  def recipe_fixture(attrs \\ %{}) do
    {:ok, recipe} =
      attrs
      |> Enum.into(%{
        dish: "some dish",
        ingredients: "some ingredients",
        instructions: "some instructions"
      })
      |> SpongebobRecipeBook.Recipes.create_recipe()

    recipe
  end
end
