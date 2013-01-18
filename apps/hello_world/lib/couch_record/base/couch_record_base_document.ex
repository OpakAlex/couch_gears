defmodule CouchRecord.Base.Document do
  @moduledoc """
  Works with couchdb touple and returns document record
  Uses as mixins for CouchRecord.Document and CouchRecord.Design.Document
  """
  defmacro __using__([]) do
    quote do

      @doc """
        parses an touple to document record, and add db name to document record
      """
      def parse_to_record(body, db_name) do
        document = document.db_name(db_name)
        document.new(body)
      end

      @doc """
      returns record document with save this in couchdb
      Use for create an new document in couchdb
      """
      def create_document(body, db_name) do
        document = parse_to_record(body, db_name)
        document.save
      end
    end
  end
end