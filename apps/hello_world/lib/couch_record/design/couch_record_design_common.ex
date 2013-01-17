defmodule CouchRecord.Design.Common do
  defmacro __using__([]) do
    quote do

      defoverridable [from_list_to_dic: 0]

      #private
      defp from_list_to_dic do
        fn({key, value}) ->
          case value do
            {list_value} ->
              if design_key?(key) do
                {binary_to_atom(key), HashDict.new(list_value, from_list_to_dic_last)}
              else
                {binary_to_atom(key), HashDict.new(list_value, from_list_to_dic)}
              end
            _ -> {binary_to_atom(key), value}
          end
        end
      end

      defp design_key?(key) do
        (key == "views" || key == "lists" || key == "shows")
      end

      defp from_list_to_dic_last do
        fn({key, value}) ->
          {binary_to_atom(key), value}
        end
      end
    end
  end
end