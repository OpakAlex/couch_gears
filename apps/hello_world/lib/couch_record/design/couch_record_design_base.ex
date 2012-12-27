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
          case get_value_from_json(name, content(type, rec)) do
            :not_found -> false
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
        {body} = get_value_from_json(name, content(type, rec))
        body
      end

      def refresh_body(type, body, rec) do
        body = [{plural(type), {body}}] ++ List.keydelete(rec.body, plural(type), 0)
      end

      def content(type, rec) do
        case rec.attrs[plural(:atom, type)] do
          nil -> nil
          {body} -> body
        end
      end

      defp plural(:atom, singl) do
        binary_to_atom("#{to_binary(singl)}s")
      end

      defp plural(singl) do
        "#{to_binary(singl)}s"
      end

    end
  end
end