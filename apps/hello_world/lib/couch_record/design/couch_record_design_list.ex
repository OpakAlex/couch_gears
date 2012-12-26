defmodule CouchRecord.Design.List do
  defmacro __using__(opts) do
    quote do

      def lists(rec) do
        key_to_atom(Keyword.keys(content(:list, rec)))
      end

    end
  end
end