defmodule CouchRecord.Base do
  defmacro __using__([]) do
    quote do

      #common functions
      use CouchRecord.Base.Common

      #helpers
      import CouchRecord.Base.Helpers

      #include attrs functions for record
      use CouchRecord.Base.DocAttrs

      #include crud

      use CouchRecord.Base.CRUD

      #include json_methods
      use CouchRecord.Base.JsonMethods

      #include save methods
      use CouchRecord.Base.Save

      #errors
     import CouchRecord.Base.Errors

      def body(body, rec) do
        document(rec, body: body)
      end

      def new(body, rec) do
        doc = document(rec, body: body)
        doc.attrs(HashDict.new(body, from_list_to_dic))
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


      def design?(rec) do
        Regex.match?(%r/^_design/, rec.attrs[:_id])
      end

      #private
      defp keys(rec) do
        rec.attrs.keys()
      end

    end
  end
end