defmodule SpongebobRecipeBook.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :admin, :boolean, default: false
    field :hashed_password, :string
    field :username, :string
    has_many :recipes, SpongebobRecipeBook.Recipes.Recipe

    timestamps()
  end

  @spec changeset(
          {map, map}
          | %{
              :__struct__ => atom | %{:__changeset__ => map, optional(any) => any},
              optional(atom) => any
            },
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :hashed_password])
    |> validate_required([:username, :hashed_password])
    |> validate_length(:username, max: 30)
    |> unique_constraint(:username)
    |> put_password_hash()
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{hashed_password: hashed_password}} = changeset) do
    change(changeset, hashed_password: Bcrypt.hash_pwd_salt(hashed_password))
  end

  defp put_password_hash(changeset), do: changeset
end
