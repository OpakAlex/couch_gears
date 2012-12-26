defmodule CouchRecord.BaseCommon do

  def keys_to_atoms(body) do
     Enum.map keys(body), fn(el) ->
       {el, get_value_from_json(to_binary(el), body)}
     end
   end

   def to_binary_field([{k,v}]) do
    [{to_binary(k), v}]
   end

   def key_to_atom([], acc) do
      acc
    end

    def key_to_atom([h|t], acc) do
      key_to_atom(t, [binary_to_atom(h, :utf8) | acc])
    end

    def key_to_atom(keys) do
      key_to_atom(keys, [])
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

    defp keys(body) do
      key_to_atom(Keyword.keys(body))
    end

end