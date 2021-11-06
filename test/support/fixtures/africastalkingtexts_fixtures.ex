defmodule Bestnowelixirmysql.AfricastalkingtextsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bestnowelixirmysql.Africastalkingtexts` context.
  """

  @doc """
  Generate a africastalkingtext.
  """
  def africastalkingtext_fixture(attrs \\ %{}) do
    {:ok, africastalkingtext} =
      attrs
      |> Enum.into(%{
        cost: "some cost",
        messageId: "some messageId",
        messageParts: 42,
        number: 42,
        sentmessage: "some sentmessage",
        status: "some status",
        statusCode: 42
      })
      |> Bestnowelixirmysql.Africastalkingtexts.create_africastalkingtext()

    africastalkingtext
  end
end
