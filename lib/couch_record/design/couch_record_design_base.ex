defmodule CouchRecord.Design.Base do
  @moduledoc """
  Base module for design documents
  """
  defmacro __using__([]) do
    quote do

      #mixs design crud
      use CouchRecord.Design.CRUD

      #mixs view
      use CouchRecord.Design.View

      #mixs show
      use CouchRecord.Design.Show

      #mixs list
      use CouchRecord.Design.List

      #mixs validate_doc_update
      use CouchRecord.Design.Validation

      #mixs updates
      use CouchRecord.Design.Update

      @doc """
      returns true if design document has views|lists|shows|updates|validations fields; else - false
      """
      def exist?(type, rec) do
        rec.attr?(plural(:atom, type))
      end

      @doc """
      returns true if design document has views|lists|shows|updates|validations with given name; else - false
      """
      def exist?(type, name, rec) do
        if rec.exist?(type) do
          case rec.attrs[plural(:atom, type)][name] do
            nil -> false
            _ -> true
          end
        else
          false
        end
      end

      @doc """
      returns name for design document
      """
      def name(rec) do
        Regex.replace(%r(_design/), rec.attrs[:_id], '')
      end

      @doc """
      returns body for view, list, show, update fields
      """
      def body(type, name, rec) do
        {body} = rec.attrs[plural(:atom, type)][name]
        body
      end

      @doc """
      returns pluar for singl word
      """
      def plural(:atom, singl) do
        binary_to_atom("#{to_binary(singl)}s")
      end

    end
  end
end