defmodule CouchRecord.Design.List do
  defmacro __using__([]) do
    quote do

      def lists(rec) do
        case rec.attrs[:lists] do
          nil -> nil
          lists   -> lists.keys()
        end
      end

    end
  end
end