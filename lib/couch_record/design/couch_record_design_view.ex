defmodule CouchRecord.Design.View do
  @moduledoc """
  View functions for design documets
  """
  defmacro __using__([]) do
    quote do

      @doc """
      returns list of atoms for design documents views names
      """
      def views(rec) do
        case rec.attrs[:views] do
          nil -> nil
          views   -> views.keys()
        end
      end

    end
  end
end