defmodule Bestnowelixirmysql.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Bestnowelixirmysql.Repo,
      # Start the Telemetry supervisor
      BestnowelixirmysqlWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Bestnowelixirmysql.PubSub},
      # Start the Endpoint (http/https)
      BestnowelixirmysqlWeb.Endpoint
      # Start a worker by calling: Bestnowelixirmysql.Worker.start_link(arg)
      # {Bestnowelixirmysql.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Bestnowelixirmysql.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BestnowelixirmysqlWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  def get_url(live_url, sandbox_url) do
    cond do
      Application.get_env(:at_ex, :sandbox) === false -> live_url
      Application.get_env(:at_ex, :sandbox) === true -> sandbox_url
      true -> sandbox_url
    end
  end
end
