defmodule CouchRecord.Design.Show do
  defmacro __using__([]) do
    quote do

      def shows(rec) do
        key_to_atom(Keyword.keys(content(:show, rec)))
      end

    end
  end
end