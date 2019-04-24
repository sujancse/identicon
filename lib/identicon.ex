defmodule Identicon do
  @moduledoc """
  Documentation for Identicon.
  """

  alias Identicon.Image

  @doc """
  Generating name hash

  ## Examples
    Identicon.generate("sujan")
  """
  def generate(name) do
    name
    |> hash
    |> pick_color
  end

  def hash(name) do
    hex =
      :crypto.hash(:md5, name)
      |> :binary.bin_to_list()

    %Image{hex: hex}
  end

  @doc """
  Picking color

  ## Examples
    Identicon.pick_color(image)
  """
  def pick_color(%Image{hex: [r, g, b | _tail]} = image) do
    %Image{image | color: {r, g, b}}
  end
end
