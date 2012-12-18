defmodule ActiveResource.Common do

  def atom_keys(body) do
     Enum.map keys(body), fn(el) ->
       {el, get_value_from_json(to_binary(el), body)}
     end
   end

   def to_binary_field([{k,v}]) do
    [{to_binary(k), v}]
   end

   defp get_value_from_json(field, body) do
     :proplists.get_value(field, body, :nil) #Keyword.get work only atom
   end

   defp keys(body) do
     List.flatten(key_to_atom(Keyword.keys(body)))
   end

   defp key_to_atom([]) do
      []
    end

    defp key_to_atom([h|t]) do
      key_to_atom(h) ++ key_to_atom(t)
    end

    defp key_to_atom(key) do
      [binary_to_atom(key, :utf8)]
    end

end