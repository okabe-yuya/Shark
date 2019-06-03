defmodule SharkEditer do
  require SharkColumn
  def filter(cdl, column_name, func) when is_function(func) do
    index_num = SharkColumn.val_index_in_header(cdl, column_name)
    body =
      cdl
      |> Stream.drop(1)
      |> Stream.filter(&(func.(Enum.at(&1, index_num))))
    Stream.concat([Stream.take(cdl, 1), body])
  end

  def filter(cdl, column_name, val) do
    index_num = SharkColumn.val_index_in_header(cdl, column_name)
    body =
      cdl
      |> Stream.drop(1)
      |> Stream.filter(&(Enum.at(&1, index_num) == val))
    Stream.concat(Stream.take(cdl, 1), body)
  end

  def str_to_integer(cdl, column_name) do
    index_num = SharkColumn.val_index_in_header(cdl, column_name)
    IO.puts(index_num)
    body =
      cdl
      |> Stream.drop(1)
      |> Stream.map(
        fn row ->
          #TODO: validate, not convert to string
          IO.inspect(row)
          List.update_at(row, index_num, fn x -> String.to_integer(x) end)
        end
      )
    Stream.concat(Stream.take(cdl, 1), body)
  end
  def remove_blank(cdl) do
    cdl
    |> Stream.filter(&(!Enum.member?(&1, "")))
  end

  def fill_to_blank(cdl, column_name, val) do
    index_num = SharkColumn.val_index_in_header(cdl, column_name)
    Stream.map(cdl, fn row ->
      List.update_at(row, index_num, fn _ -> val end)
    end)
  end

  def remove_duplicate(cdl), do: cdl |> Stream.uniq()
end
