defmodule SpongebobRecipeBookWeb.PageController do
  use SpongebobRecipeBookWeb, :controller

  def home(conn, _params) do


    render(conn, :home, layout: false)
  end

  def sign_in(conn, _params) do


    render(conn, :sign_in, layout: false)
  end

  def sign_up(conn, _params) do


    render(conn, :sign_up, layout: false)
  end

  def all_recipes(conn, _params) do

    render(conn, :all_recipes, layout: false)
  end

  def single_recipe(conn, _params) do


    render(conn, :single_recipe, layout: false)
  end
end
