defmodule ActiveResource.CouchDocumentExtend do
  defmacro __using__(opts) do
    quote do

      import ActiveResource.Common
      defrecordp :document, unquote(opts)

      def body(body, rec) do
        document(rec, body: body)
      end

      def body(document(body: body)) do
        body
      end

      def db_name(document(db_name: db_name)) do
        db_name
      end

      def db_name(db_name, rec) do
        document(rec, db_name: db_name)
      end

      def attrs(document(body: body)) do
        HashDict.new(atom_keys(body))
      end

      def has_field?(name, rec) do
        :proplists.is_defined(to_binary(name), rec.body)
      end

      def delete_document(rec) do
        mark_as_delete_and_save(rec)
        :ok
      end

      def create_field(field, rec) do
        body = rec.body ++ to_binary_field(field)
        save(body, rec)
      end

      def update_field([{key, value}], rec) do
        body = remove_field(key, rec)
        body = body ++ [{to_binary(key), value}]
        save(body, rec)
      end

      def delete_field(key, rec) do
        body = remove_field(key, rec)
        save(body, rec)
      end

      defp remove_field(key, rec) do
        :proplists.delete(to_binary(key), rec.body)
      end

      def rename_field(name, new_name, rec) do
        value = rec.attrs[name]
        body = remove_field(name, rec)
        rec = rec.body(body)
        rec.create_field([{new_name, value}])
      end

      def fields_to_json(fields, rec) do
        case Enum.empty? fields do
          true -> fields_to_json(rec)
          false -> {doc_with_fields(fields, rec)}
        end
      end

      def fields_to_json(rec) do
        {rec.body}
      end

      def without_fields_to_json(fields, rec) do
        fields = Enum.map all_fields(rec), fn(x) ->
          case include?(fields, x) do
            true -> []
            nil -> x
          end
        end
        fields_to_json(List.flatten(fields), rec)
      end

      def to_json(rec) do
        {rec.body}
      end

      #private

      defp mark_as_delete_and_save(rec) do
        save(rec.body ++ [{"_deleted", true}], rec)
      end


      defp all_fields(rec) do
        Enum.map :proplists.get_keys(rec.body), fn(x) ->
          binary_to_atom(x)
        end
      end

      defp save(body, rec) do
        save_to_db(rec.db_name, body)
        rec.body(body)
      end

      defp doc_with_fields(fields, rec) do
        Enum.map fields, fn(field) ->
          {to_binary(field), rec.attrs[field]}
        end
      end


      #list adds
      defp include?(array, value) do
        Enum.find_value(array, fn(x) -> x == value end)
      end

    end
  end
end