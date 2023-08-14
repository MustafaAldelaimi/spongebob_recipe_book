defmodule SpongebobRecipeBookWeb.RecipeController do
  use SpongebobRecipeBookWeb, :controller

  alias SpongebobRecipeBook.Recipes
  alias SpongebobRecipeBook.Recipes.Recipe

  import SpongebobRecipeBookWeb.Auth.AuthorizedPlug

  plug :is_authorized when action in [:update, :delete]

  action_fallback SpongebobRecipeBookWeb.FallbackController

  def index(conn, _params) do
    recipes = Recipes.list_recipes()
    render(conn, :index, recipes: recipes)
  end

  def create(conn, %{"recipe" => recipe_params}) do
    with {:ok, %Recipe{} = recipe} <- Recipes.create_recipe(recipe_params) do
      conn
      |> put_status(:created)
      |> render(:show, recipe: recipe)
    end
  end

  def show(conn, %{"id" => id}) do
    recipe = Recipes.get_recipe!(id)
    render(conn, :show, recipe: recipe)
  end

  def update(conn, %{"recipe" => recipe_params}) do

    recipe_to_update = Enum.find(conn.assigns.user.recipes, fn recipe ->
      recipe.id == recipe_params["id"]
    end)

    with {:ok, %Recipe{} = recipe} <- Recipes.update_recipe(recipe_to_update, recipe_params) do
      render(conn, :show, recipe: recipe)
    end
  end

  def delete(conn, %{"id" => id}) do
    recipe = Recipes.get_recipe!(id)

    with {:ok, %Recipe{}} <- Recipes.delete_recipe(recipe) do
      send_resp(conn, :no_content, "")
    end
  end
end
