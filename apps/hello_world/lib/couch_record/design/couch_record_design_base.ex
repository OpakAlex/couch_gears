defmodule CouchRecord.Design.Base do
  defmacro __using__([]) do
    quote do

      #crud
      use CouchRecord.Design.CRUD

      #view
      use CouchRecord.Design.View

      #show
      use CouchRecord.Design.Show

      #list
      use CouchRecord.Design.List

      #validate_doc_update
      use CouchRecord.Design.Validation

      #updates
      use CouchRecord.Design.Update


      def exist?(type, rec) do
        rec.attr?(plural(:atom, type))
      end

      def exist?(type, name, rec) do
        if rec.exist?(type) do
          case rec.attrs[plural(:atom, type)][name] do
            nil -> false
            _ -> true
          end
        else
          false
        end
      end

      def name(rec) do
        Regex.replace(%r(_design/), rec.attrs[:_id], '')
      end

      def body(type, name, rec) do
        {body} = rec.attrs[plural(:atom, type)][name]
        body
      end

      def plural(:atom, singl) do
        binary_to_atom("#{to_binary(singl)}s")
      end

    end
  end
end