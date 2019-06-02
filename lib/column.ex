defmodule SharkColumn do
  def add_header(cdl, column_name, init_val, is_head \\ false) do
    new_header = _add_header(cdl, column_name, init_val, is_head)
    new_header
  end

  defp _add_header(cdl, column_name, init_val, is_head) do
    index_num = if is_head == true, do: 0, else: -1
    header =
      Stream.take(cdl, 1)
      |> Stream.map(&(List.insert_at(&1, index_num, column_name)))
    body =
      cdl
      |> Stream.map(&(List.insert_at(&1, index_num, init_val)))
      |> Stream.drop(1)
    Stream.concat([header, body])
  end
end
