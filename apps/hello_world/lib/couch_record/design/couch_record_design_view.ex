defmodule CouchRecord.Design.View do
  defmacro __using__(opts) do
    quote do

      def views(rec) do
        key_to_atom(Keyword.keys(content(:view, rec)))
      end

    end
  end
end