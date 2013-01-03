defmodule CouchRecord.Base.Common do

   def key_to_atom([], acc) do
      acc
    end

    def key_to_atom([h|t], acc) do
      key_to_atom(t, [to_atom(h) | acc])
    end

    def key_to_atom(keys) do
      key_to_atom(keys, [])
    end

    def to_list_binary(dict) do
      Enum.map dict.keys(), fn(el) ->
         {to_binary(el), dict[el]}
       end
    end

    def get_value_from_json(field, body) do
      case List.keyfind(body, to_binary(field), 0) do
        {key, value} -> value
        nil -> :not_found
      end
    end

    #list adds
    def include?(array, value) do
      Enum.find_value(array, fn(x) -> x == value end)
    end

    def to_atom(value) do
      case is_atom(value) do
        true -> value
        false -> binary_to_atom(value)
      end
    end

    defp keys(body) do
      key_to_atom(Keyword.keys(body))
    end

end