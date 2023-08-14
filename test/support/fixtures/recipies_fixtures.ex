defmodule SpongebobRecipeBook.RecipiesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SpongebobRecipeBook.Recipies` context.
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
      |> SpongebobRecipeBook.Recipies.create_recipe()

    recipe
  end
end
