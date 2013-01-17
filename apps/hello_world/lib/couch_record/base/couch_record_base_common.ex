defmodule CouchRecord.Base.Common do
    defmacro __using__([]) do
      quote do
        def from_list_to_dic do
          fn({key, value}) ->
            case value do
              {list_value} -> {binary_to_atom(key), HashDict.new(list_value, from_list_to_dic)}
                     _ -> {binary_to_atom(key), value}
            end
          end
        end
      end
    end
end