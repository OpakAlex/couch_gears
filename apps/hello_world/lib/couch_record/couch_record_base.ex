defmodule CouchRecord.Base do
  defmacro __using__([]) do
    quote do

      #helper functions
      import CouchRecord.Base.Common

      #include attrs functions for record
      use CouchRecord.Base.DocAttrs

      #include crud

      use CouchRecord.Base.CRUD

      #include json_methods
      use CouchRecord.Base.JsonMethods

      def body(body, rec) do
        document(rec, body: body)
      end

      def new(body, rec) do
        doc = document(rec, body: body)
        doc.attrs(HashDict.new(keys_to_atoms(body)))
      end

      def attrs(dict, rec) do
        document(rec, attrs: dict)
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
        Dict.has_key?(rec.attrs, name)
      end

      def design?(rec) do
        Regex.match?(%r/^_design/, rec.attrs[:_id])
      end

      def apply_changes(rec) do
        rec.body(to_list_binary(rec.attrs))
      end

      def apply_changes(body, rec) do
        rec.new(body)
      end

      #private
      defp keys(rec) do
        rec.attrs.keys()
      end

    end
  end
end