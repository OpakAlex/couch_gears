defmodule CouchRecord.Common do

  def keys_to_atoms(body) do
     Enum.map keys(body), fn(el) ->
       {el, get_value_from_json(to_binary(el), body)}
     end
   end

   def to_binary_field([{k,v}]) do
    [{to_binary(k), v}]
   end

   def key_to_atom([]) do
      []
    end

    def key_to_atom([h|t]) do
      key_to_atom(h) ++ key_to_atom(t)
    end

    def key_to_atom(key) do
      [binary_to_atom(key, :utf8)]
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
      List.flatten(key_to_atom(Keyword.keys(body)))
    end

end