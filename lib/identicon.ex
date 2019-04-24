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
    |> get_even_squares
    |> build_pixel_map
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

  @doc """
  Get even squares from image grid

  ## Examples
      Identicon.get_even_squares(image)
  """
  def get_even_squares(%Image{grid: grid} = image) do
    grid =
      Enum.filter(grid, fn {code, _index} ->
        rem(code, 2) == 0
      end)

    %Image{image | grid: grid}
  end

  @doc """
  Build pixel map

  ## Examples
      Identicon.build_pixel_map(image)
  """

  def build_pixel_map(%Image{grid: grid} = image) do
    pixel_map =
      Enum.map(grid, fn {_code, index} ->
        horizontal = rem(index, 5) * 50
        vertical = div(index, 5) * 50

        top_left = {horizontal, vertical}
        bottom_right = {horizontal + 50, vertical + 50}

        {top_left, bottom_right}
      end)

    %Image{image | pixel_map: pixel_map}
  end
end
