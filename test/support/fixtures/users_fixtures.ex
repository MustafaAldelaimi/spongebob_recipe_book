defmodule SpongebobRecipeBook.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SpongebobRecipeBook.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        admin: true,
        hashed_password: "some hashed_password",
        username: "some username"
      })
      |> SpongebobRecipeBook.Users.create_user()

    user
  end
end
