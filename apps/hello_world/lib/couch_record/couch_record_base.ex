defmodule CouchRecord.Base do
  defmacro __using__(opts) do
    quote do

    defexception Save.Error, [reason: nil] do
      def message(exception) do
        "#{exception}"
      end
    end
      #helper functions
      import CouchRecord.BaseCommon

      #include attrs functions for record
      use CouchRecord.DocAttrs

      #include json_methods
      use CouchRecord.JsonMethods

      def body(body, rec) do
        doc = document(rec, body: body)
        doc.attrs(body)
      end

      def attrs(body, rec) do
        document(rec, attrs: HashDict.new(keys_to_atoms(body)))
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

      def attrs(document(attrs: attrs)) do
        attrs
      end

      def attr?(name, rec) do
        List.keymember?(rec.body, to_binary(name), 0)
      end

      def remove_document(rec) do
        mark_as_delete(rec)
        rec
      end

      def put(key, value, rec) do
        if rec.attr?(key) do
          update(key, value, rec)
        else
          create(key, value, rec)
        end
      end

      def remove(key, rec) do
        body = remove_field(key, rec)
        save_record(body, rec)
      end

      def rename(name, new_name, rec) do
        value = rec.attrs[name]
        body = remove_field(name, rec)
        rec = rec.body(body)
        create(new_name, value, rec)
      end

      def save!(rec) do
        case CouchRecord.Db.save!(rec.db_name, rec.to_json()) do
          :ok -> true
          _ -> raise Save.Error, reason: "you have some errors in you document"
        end
      end

      def save(rec) do
        case CouchRecord.Db.save!(rec.db_name, rec.to_json()) do
          :ok -> rec
          _ -> false
        end
      end

      def design?(rec) do
        Regex.match?(%r/^_design/, rec.attrs[:_id])
      end

      def save_record(body, rec) do
        rec.body(body)
      end

      #private

      defp remove_field(key, rec) do
        List.keydelete(rec.body, to_binary(key), 0)
      end

      defp create(key, value, rec) do
        body = rec.body ++ to_binary_field([{key, value}])
        save_record(body, rec)
      end

      defp update(key, value, rec) do
        body = remove_field(key, rec)
        body = body ++ [{to_binary(key), value}]
        save_record(body, rec)
      end

      defp mark_as_delete(rec) do
        save_record(rec.body ++ [{"_deleted", true}], rec)
      end

      defp all_fields(rec) do
        Enum.map Keyword.keys(rec.body), fn(x) ->
          binary_to_atom(x)
        end
      end

    end
  end
end