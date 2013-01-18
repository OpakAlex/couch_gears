defmodule CouchRecord.Base.DocAttrs do

  @moduledoc """
  This module mix for CouchRecord.Base module and add some helper methods for document attrs
  """

  defmacro __using__([]) do
    quote do

      @doc """
      Sets attrs as dict to document, uses in new function
      """
      def attrs(dict, rec) do
        document(rec, attrs: dict)
      end

      @doc """
      returns couchdb document as dic
      """
      def attrs(document(attrs: attrs)) do
        attrs
      end


      @doc """
      returns true if field exist in document, else - false
      """
      def attr?(name, rec) do
        Dict.has_key?(rec.attrs, name)
      end

      @doc """
      returns id from couchdb document, see also - document.attrs[:_id]
      """
      def _id(rec) do
        rec.attrs[:_id]
      end

      @doc """
      returns rev from couchdb document, see also - document.attrs[:_rev
      """

      def _rev(rec) do
        rec.attrs[:_rev]
      end

    end
  end
end