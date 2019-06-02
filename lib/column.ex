defmodule SharkColumn do
  def add_header(cdl, column_name, init_val, is_head \\ false) do
    _add_header(cdl, column_name, init_val, is_head)
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

  def remove_header(cdl, column_name) do
    key_index_num =
      cdl
      |> res_cdl_header()
      |> Enum.find_index(fn val -> val == column_name end)
    Stream.map(cdl, &(List.delete_at(&1, key_index_num)))
  end

  def is_exist_name_in_header(cdl, column_name) do
    cdl
    |> res_cdl_header()
    |> Enum.member?(column_name)
  end

  def res_cdl_header(cdl) do
    cdl
    |> Stream.take(1)
    |> Enum.to_list()
    |> List.first()
  end
end
