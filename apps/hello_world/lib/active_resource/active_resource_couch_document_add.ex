defmodule ActiveResource.CouchDocumentAdd do
  defmacro __using__(opts) do
    quote do

      #define default records
      defrecordp :document, unquote(opts)
      defrecord Document, [__attributes__: nil, __methods__: nil]

      def new(proplist, rec) do
        proplist = [__attributes__: proplist] ++ [{:__methods__, rec}]
        Document.new(proplist)
      end

      def db_name(document(db_name: db_name)) do
        db_name
      end

      def db_name(db_name, rec) do
        document(rec, db_name: db_name)
      end

      def _id(doc, rec) do
        field(:_id, doc, rec)
      end

      def _rev(doc, rec) do
        field(:_rev, doc, rec)
      end

      def has_field?(name, doc, rev) do
        :proplists.is_defined(to_binary(name), attrs(doc))
      end

      def field(name,  doc, rec) do
        :proplists.get_value(to_binary(name), attrs(doc), :nil)
      end

      def delete_document(doc,rec) do
        mark_as_delete(doc, rec)
        :ok
      end

      def create_field([{key, value}], doc, rec) do
        tmp_attrs = attrs(doc) ++ [{to_binary(key), value}]
        save(tmp_attrs, doc, rec)
      end

      def update_field([{key, value}], doc, rec) do
        proplist = remove_field(key, doc, rec)
        proplist = proplist ++ [{to_binary(key), value}]
        save(proplist, doc, rec)
      end

      def delete_field(key, doc, rec) do
        proplist = remove_field(key, doc, rec)
        save(proplist, doc, rec)
      end

      defp remove_field(key, doc, rev) do
        :proplists.delete(to_binary(key), attrs(doc))
      end

      def rename_field(name, new_name, doc, rec) do
        value = field(name, doc, rec)
        proplist = proplist_attrs(remove_field(name, doc, rec), doc, rec)
        doc = doc.update(proplist)
        create_field([{new_name, value}], doc, rec)
      end

      def with_fields(fields, doc, rec) do
        case Enum.empty? fields do
          true -> with_fields(doc, rec)
          false -> doc_with_fields(fields, doc, rec)
        end
      end

      def with_fields(doc, rec) do
        attrs(doc)
      end

      def with_fields(fields, doc, :to_json, rec) do
        {with_fields(fields, doc, rec)}
      end

      def without_fields(fields, doc, rec) do
        fields = Enum.map all_fields(doc, rec), fn(x) ->
          case include?(fields, x) do
            true -> []
            nil -> x
          end
        end
        with_fields(List.flatten(fields), doc, rec)
      end

      def without_fields(fields, doc, :to_json, rec) do
        {without_fields(fields, doc, rec)}
      end

      def to_json(doc, rec) do
        {attrs(doc)}
      end

      #private

      defp mark_as_delete(doc, rec) do
        save(attrs(doc) ++ [{"_deleted", true}], rec)
      end

      defp proplist_attrs(attrs, doc, rec) do
        [__attributes__: attrs] ++ [{:__methods__, rec}]
      end

      defp all_fields(doc, rec) do
        :proplists.get_keys(attrs(doc))
      end

      defp save(proplist, doc, rec) do
        ActiveResource.Utils.save_to_db(rec.db_name, proplist)
        proplist = proplist_attrs(proplist, doc, rec)
        doc.update(proplist)
      end

      defp doc_with_fields(fields, doc, rec) do
        Enum.map fields, fn(_field) ->
          {to_binary(_field), field(_field, doc, rec)}
        end
      end

      defp attrs(doc) do
        doc.__attributes__
      end

      #list adds
      defp include?(array, value) do
        Enum.find_value(array, fn(x) -> to_binary(x) == value end)
      end

    end
  end
end