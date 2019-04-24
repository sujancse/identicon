defmodule Identicon do
  @moduledoc """
  Documentation for Identicon.
  """

  alias Identicon.Image

  @doc """
  Generate identicon from input

  ## Examples
    Identicon.generate("sujan")
  """
  def generate(input) do
    input
    |> hash
    |> pick_color
    |> build_grid
  end

  def hash(input) do
    hex =
      :crypto.hash(:md5, input)
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

  @doc """
  Building image grid

  ## Examples
      Identicon.build_grid(image)
  """

  def build_grid(%Image{hex: hex} = image) do
    grid =
      hex
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten()
      |> Enum.with_index()

    %Image{image | grid: grid}
  end

  def mirror_row(row) do
    [first, second | _tail] = row
    row ++ [second, first]
  end
end
