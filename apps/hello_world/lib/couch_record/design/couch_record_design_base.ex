defmodule CouchRecord.Design.Base do
  defmacro __using__(opts) do
    quote do

      #crud
      use CouchRecord.Design.CRUD

      #view
      use CouchRecord.Design.View

      def name(rec) do
        Regex.replace(%r(_design/), rec.attrs[:_id], '')
      end

    end
  end
end