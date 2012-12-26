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

      def design?(rec) do
        Regex.match?(%r/^_design/, rec.attrs[:_id])
      end

      def save_record(body, rec) do
        rec.body(body)
      end

      #private

      defp all_fields(rec) do
        Enum.map Keyword.keys(rec.body), fn(x) ->
          binary_to_atom(x)
        end
      end

    end
  end
end