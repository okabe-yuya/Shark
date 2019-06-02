defmodule SharkEditer do
  def remove_black(cdl) do
    cdl
    |> Stream.filter(&(!Enum.member?(&1, "")))
  end
end
