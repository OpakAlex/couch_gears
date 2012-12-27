defmodule CouchRecord.Design.Show do
  defmacro __using__([]) do
    quote do

      def shows(rec) do
        case content(:show, rec) do
          nil -> nil
          body -> key_to_atom(Keyword.keys(body))
        end
      end

    end
  end
end