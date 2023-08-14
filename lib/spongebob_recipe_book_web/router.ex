defmodule SpongebobRecipeBookWeb.Router do
  use SpongebobRecipeBookWeb, :router
  use Plug.ErrorHandler

  defp handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  defp handle_errors(conn, %{reason: %{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {SpongebobRecipeBookWeb.Layouts, :root}
    # plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  pipeline :auth do
    plug SpongebobRecipeBookWeb.Auth.Pipeline
    plug SpongebobRecipeBookWeb.Auth.SetUser
  end

  scope "/", SpongebobRecipeBookWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/sign_in", PageController, :sign_in
    get "/sign_up", PageController, :sign_up
    get "/recipes", PageController, :all_recipes
    get "/recipes/:id", PageController, :single_recipe

    post "/users/create", UserController, :create
    post "/users/sign_in", UserController, :sign_in
  end

  scope "/", SpongebobRecipeBookWeb do
    pipe_through [:api, :auth]
    get "/users/current", UserController, :current_user
    get "/users/sign_out", UserController, :sign_out
    get "/users/refresh_session", UserController, :refresh_session
    post "/users/update", UserController, :update
    put "/recipes/update", RecipeController, :update
  end

  # Other scopes may use custom stacks.
  # scope "/api", SpongebobRecipeBookWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:spongebob_recipe_book, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: SpongebobRecipeBookWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
