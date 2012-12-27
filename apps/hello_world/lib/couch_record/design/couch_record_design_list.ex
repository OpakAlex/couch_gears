defmodule CouchRecord.Design.List do
  defmacro __using__([]) do
    quote do

      def lists(rec) do
        case content(:list, rec) do
          nil -> nil
          body -> key_to_atom(Keyword.keys(body))
        end
      end

    end
  end
end