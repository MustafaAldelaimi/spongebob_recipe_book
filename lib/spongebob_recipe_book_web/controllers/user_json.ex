defmodule SpongebobRecipeBookWeb.UserJSON do
  alias SpongebobRecipeBookWeb.RecipeJSON
  alias SpongebobRecipeBook.Users.User

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      admin: user.admin,
      username: user.username,
      hashed_password: user.hashed_password
    }
  end

  def render("full_user.json", %{user: user}) do
    %{
      id: user.id,
      admin: user.admin,
      username: user.username,
      recipes: RecipeJSON.show(%{recipe: user.recipes})
    }
  end

  def render("user_token.json", %{user: user, token: token}) do
    %{
      id: user.id,
      admin: user.admin,
      username: user.username,
      token: token
    }
  end
end
