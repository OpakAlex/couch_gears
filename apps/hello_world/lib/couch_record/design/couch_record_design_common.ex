defmodule CouchRecord.Design.Common do
  defmacro __using__([]) do
    quote do
      def new(body, rec) do
        doc = document(rec, body: body)
        doc.attrs(HashDict.new(body, dict_atom_func))
      end

      #private
      defp dict_atom_func do
        fn({key, value}) ->
          case value do
            {list_value} ->
              if design_key?(key) do
                {binary_to_atom(key), HashDict.new(list_value, dict_atom_func_last)}
              else
                {binary_to_atom(key), HashDict.new(list_value, dict_atom_func)}
              end
            _ -> {binary_to_atom(key), value}
          end
        end
      end

      defp design_key?(key) do
        (key == "views" || key == "lists" || key == "shows")
      end

      defp dict_atom_func_last do
        fn({key, value}) ->
          {binary_to_atom(key), value}
        end
      end
    end
  end
end