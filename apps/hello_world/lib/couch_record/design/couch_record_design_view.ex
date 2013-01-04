defmodule CouchRecord.Design.View do
  defmacro __using__([]) do
    quote do

      def views(rec) do
        case rec.attrs[:views] do
          nil -> nil
          views   -> views.keys()
        end
      end

    end
  end
end