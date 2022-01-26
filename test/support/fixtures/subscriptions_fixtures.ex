defmodule Bestnowelixirmysql.SubscriptionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bestnowelixirmysql.Subscriptions` context.
  """

  @doc """
  Generate a subscription.
  """
  def subscription_fixture(attrs \\ %{}) do
    {:ok, subscription} =
      attrs
      |> Enum.into(%{
        active: true,
        days: 42,
        uid: 42
      })
      |> Bestnowelixirmysql.Subscriptions.create_subscription()

    subscription
  end
end
