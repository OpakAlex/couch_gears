defmodule CouchRecord.Design.List do
  @moduledoc """
  List functions for design documets
  """
  defmacro __using__([]) do
    quote do

      @doc """
      returns list of atoms for design documents lists names
      """
      def lists(rec) do
        case rec.attrs[:lists] do
          nil -> nil
          lists   -> lists.keys()
        end
      end

    end
  end
end