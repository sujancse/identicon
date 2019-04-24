defmodule Identicon do
  @moduledoc """
  Documentation for Identicon.
  """

  alias Identicon.Image

  @doc """
  Generating name hash

  ## Examples

      iex> Identicon.generate("sujan")
      %Identicon.Image{
        hex: [147, 224, 90, 4, 20, 53, 192, 131, 80, 76, 152, 109, 232, 92, 171, 161]
      }

  """
  def generate(name) do
    name
    |> hash
  end

  def hash(name) do
    hex =
      :crypto.hash(:md5, name)
      |> :binary.bin_to_list()

    %Image{hex: hex}
  end
end
