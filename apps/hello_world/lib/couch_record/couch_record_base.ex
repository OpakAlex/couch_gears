defmodule CouchRecord.Base do
  defmacro __using__(opts) do
    quote do

      #helper functions
      import CouchRecord.Common

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
        mark_as_delete_and_save(rec)
        :ok
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
        rec.create(new_name, value)
      end

      def design?(rec) do
        Regex.match?(%r/^_design/, rec.attrs[:_id])
      end

      #private

      defp remove_field(key, rec) do
        List.keydelete(rec.body, to_binary(key), 0)
      end

      def create(key, value, rec) do
        body = rec.body ++ to_binary_field([{key, value}])
        save_record(body, rec)
      end

      def update(key, value, rec) do
        body = remove_field(key, rec)
        body = body ++ [{to_binary(key), value}]
        save_record(body, rec)
      end

      defp mark_as_delete_and_save(rec) do
        save(rec.body ++ [{"_deleted", true}], rec)
      end

      defp all_fields(rec) do
        Enum.map Keyword.keys(rec.body), fn(x) ->
          binary_to_atom(x)
        end
      end

      defp save(body, rec) do
        save!(rec.db_name, body)
        rec.body(body)
      end

      defp save_record(body,rec) do
        rec.body(body)
      end

    end
  end
end