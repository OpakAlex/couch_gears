defmodule CouchRecord.Design.View do
  defmacro __using__([]) do
    quote do

      def views(rec) do
        case content(:view, rec) do
          nil -> nil
          body -> key_to_atom(Keyword.keys(body))
        end
      end

    end
  end
end