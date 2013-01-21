defmodule CouchRecord.Base do
  @moduledoc """
  Gives simple finctions and mixs base modules for work with document record
  """
  defmacro __using__([]) do
    quote do

      #mixs helpers
      import CouchRecord.Base.Helpers

      #mixs attrs functions for record
      use CouchRecord.Base.DocAttrs

      #mixs crud
      use CouchRecord.Base.CRUD

      #mixs json_methods
      use CouchRecord.Base.JsonMethods

      #mixs save methods
      use CouchRecord.Base.Save

      #imports errors for saves
      import CouchRecord.Base.Errors

      @doc """
      sets couchdb touple to record
      """
      def body(body, rec) do
        document(rec, body: body)
      end

      @doc """
      creates new document record
      """
      def new(body, rec) do
        doc = document(rec, body: body)
        doc.attrs(HashDict.new(body, from_list_to_dic()))
      end

      @doc """
      returns couchdb document touple
      """
      def body(document(body: body)) do
        body
      end

      @doc """
      returns db_name for document
      """
      def db_name(document(db_name: db_name)) do
        db_name
      end

      @doc """
      sets db_name to record
      """
      def db_name(db_name, rec) do
        document(rec, db_name: db_name)
      end

      @doc """
      returns true if document is design doucment; else - false
      """
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