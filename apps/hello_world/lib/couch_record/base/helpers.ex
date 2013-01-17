defmodule CouchRecord.Base.Helpers do
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
        element = dict[el]
        case is_dict?(element) do
          true -> {to_binary(el), {to_list_binary(element)}}
          false -> {to_binary(el), element}
        end
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

    defp is_dict?(value) do
      case value do
        {HashDict, _} -> true
        _ -> false
      end
    end
end
