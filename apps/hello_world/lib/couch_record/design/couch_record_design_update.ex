defmodule CouchRecord.Design.Update do
  defmacro __using__([]) do
    quote do
      def updates(rec) do
        case content(:updates, rec) do
          nil -> nil
          body -> key_to_atom(Keyword.keys(body))
        end
      end
    end
  end
end