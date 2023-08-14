defmodule SpongebobRecipeBookWeb.UserController do
  use SpongebobRecipeBookWeb, :controller

  alias SpongebobRecipeBookWeb.{Auth.Guardian, Auth.ErrorResponse}
  alias SpongebobRecipeBook.{Users, Users.User}

  import SpongebobRecipeBookWeb.Auth.AuthorizedPlug
  plug :is_authorized when action in [:update, :delete]

  action_fallback SpongebobRecipeBookWeb.FallbackController



  def index(conn, _params) do
    users = Users.list_users()
    render(conn, :index, users: users)
  end

  def create(conn, %{"user" => user_params}) do
    case Users.create_user(user_params) do
      {:ok, _} ->
        authorize_user(conn, user_params["username"], user_params["hashed_password"])
      _ ->
        raise ErrorResponse.Unauthorized, message: "Username or password already taken."
    end
  end

  def sign_in(conn, %{"username" => username, "hashed_password" => hashed_password}) do
    authorize_user(conn, username, hashed_password)
  end

  defp authorize_user(conn, username, hashed_password) do
    case Guardian.authenticate(username, hashed_password) do
      {:ok, user, token} ->
        conn
        |> Plug.Conn.put_session(:user_id, user.id)
        |> put_status(:ok)
        |> render("user_token.json", %{user: user, token: token})
      {:error, :unauthorized} -> raise ErrorResponse.Unauthorized, message: "Username or password incorrect."
    end
  end

  def refresh_session(conn, %{}) do
    token = Guardian.Plug.current_token(conn)
    {:ok, user, new_token} = Guardian.authenticate(token)
    conn
    |> Plug.Conn.put_session(:user_id, user.id)
    |> put_status(:ok)
    |> render("user_token.json", %{user: user, token: new_token})
  end

  def sign_out(conn, %{}) do
    user = conn.assigns[:user]
    token = Guardian.Plug.current_token(conn)
    Guardian.revoke(token)
    conn
    |> Plug.Conn.clear_session()
    |> put_status(:ok)
    |> render("user_token.json", %{user: user, token: nil})
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_full_user(id)
    render(conn, "full_user.json", user: user)
  end

  def current_user(conn, %{}) do
    conn
    |> put_status(:ok)
    |> render("full_user.json", %{user: conn.assigns.user})
  end

  def update(conn, %{"current_hash" => current_hash, "user" => user_params}) do
    case Guardian.validate_password(current_hash, conn.assigns.user.hashed_password) do
      true ->
        {:ok, user} = Users.update_user(conn.assigns.user, user_params)
        render(conn, :show, user: user)
      false -> raise ErrorResponse.Unauthorized, message: "Password Incorrect"
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)

    with {:ok, %User{}} <- Users.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
