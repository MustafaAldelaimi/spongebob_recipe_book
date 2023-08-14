defmodule SpongebobRecipeBook.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      SpongebobRecipeBookWeb.Telemetry,
      # Start the Ecto repository
      SpongebobRecipeBook.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: SpongebobRecipeBook.PubSub},
      # Start Finch
      {Finch, name: SpongebobRecipeBook.Finch},
      # Start the Endpoint (http/https)
      SpongebobRecipeBookWeb.Endpoint
      # Start a worker by calling: SpongebobRecipeBook.Worker.start_link(arg)
      # {SpongebobRecipeBook.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SpongebobRecipeBook.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SpongebobRecipeBookWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
