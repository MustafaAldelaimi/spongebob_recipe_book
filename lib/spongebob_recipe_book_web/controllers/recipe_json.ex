defmodule SpongebobRecipeBookWeb.RecipeJSON do
  alias SpongebobRecipeBook.Recipes.Recipe

  @doc """
  Renders a list of recipes.
  """
  def index(%{recipes: recipes}) do
    %{data: for(recipe <- recipes, do: data(recipe))}
  end

  @doc """
  Renders a single recipe.
  """
  def show(%{recipe: recipe}) do
    %{data: data(recipe)}
  end

  defp data(recipes) when is_list(recipes) do
    Enum.map(recipes, &data/1)
  end

  defp data(%Recipe{} = recipe) do
    %{
      id: recipe.id,
      dish: recipe.dish,
      instructions: recipe.instructions,
      ingredients: recipe.ingredients
    }
  end
end
