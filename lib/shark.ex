defmodule Shark do
  @moduledoc """
  Reads the csv.
  """

  @doc """
  ## Examples

      iex> Sharl.read_csv("sample_csv)
      {:ok, _}
  """
  def read_csv(file_path) do
    case File.exists?(file_path) do
      true ->
        file_stream =
          File.stream!(file_path)
          |> CSV.decode
          |> Stream.map(fn row ->
            {_, value_lst} = row
            value_lst
          end)
        {:ok, file_stream}
        # {:ok, Enum.to_list(file_stream)}
      false ->
        {:error, "#{file_path}: no such file or directory"}
    end
  end
end
