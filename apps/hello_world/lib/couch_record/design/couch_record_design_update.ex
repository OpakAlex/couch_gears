defmodule CouchRecord.Design.Update do
  defmacro __using__([]) do
    quote do
      def updates(rec) do
        rec.attrs[:updates]
      end
    end
  end
end