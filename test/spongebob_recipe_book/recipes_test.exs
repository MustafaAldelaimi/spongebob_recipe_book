defmodule SpongebobRecipeBook.RecipesTest do
  use SpongebobRecipeBook.DataCase

  alias SpongebobRecipeBook.Recipes

  describe "recipes" do
    alias SpongebobRecipeBook.Recipes.Recipe

    import SpongebobRecipeBook.RecipesFixtures

    @invalid_attrs %{dish: nil, ingredients: nil, instructions: nil}

    test "list_recipes/0 returns all recipes" do
      recipe = recipe_fixture()
      assert Recipes.list_recipes() == [recipe]
    end

    test "get_recipe!/1 returns the recipe with given id" do
      recipe = recipe_fixture()
      assert Recipes.get_recipe!(recipe.id) == recipe
    end

    test "create_recipe/1 with valid data creates a recipe" do
      valid_attrs = %{dish: "some dish", ingredients: "some ingredients", instructions: "some instructions"}

      assert {:ok, %Recipe{} = recipe} = Recipes.create_recipe(valid_attrs)
      assert recipe.dish == "some dish"
      assert recipe.ingredients == "some ingredients"
      assert recipe.instructions == "some instructions"
    end

    test "create_recipe/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Recipes.create_recipe(@invalid_attrs)
    end

    test "update_recipe/2 with valid data updates the recipe" do
      recipe = recipe_fixture()
      update_attrs = %{dish: "some updated dish", ingredients: "some updated ingredients", instructions: "some updated instructions"}

      assert {:ok, %Recipe{} = recipe} = Recipes.update_recipe(recipe, update_attrs)
      assert recipe.dish == "some updated dish"
      assert recipe.ingredients == "some updated ingredients"
      assert recipe.instructions == "some updated instructions"
    end

    test "update_recipe/2 with invalid data returns error changeset" do
      recipe = recipe_fixture()
      assert {:error, %Ecto.Changeset{}} = Recipes.update_recipe(recipe, @invalid_attrs)
      assert recipe == Recipes.get_recipe!(recipe.id)
    end

    test "delete_recipe/1 deletes the recipe" do
      recipe = recipe_fixture()
      assert {:ok, %Recipe{}} = Recipes.delete_recipe(recipe)
      assert_raise Ecto.NoResultsError, fn -> Recipes.get_recipe!(recipe.id) end
    end

    test "change_recipe/1 returns a recipe changeset" do
      recipe = recipe_fixture()
      assert %Ecto.Changeset{} = Recipes.change_recipe(recipe)
    end
  end
end
