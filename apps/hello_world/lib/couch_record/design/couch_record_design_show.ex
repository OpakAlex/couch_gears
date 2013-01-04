defmodule CouchRecord.Design.Show do
  defmacro __using__([]) do
    quote do

      def shows(rec) do
        case rec.attrs[:shows] do
          nil -> nil
          shows   -> shows.keys()
        end
      end

    end
  end
end