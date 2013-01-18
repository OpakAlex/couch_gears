defmodule CouchRecord.Design.Show do
  @moduledoc """
  Show functions for design documets
  """
  defmacro __using__([]) do
    quote do

      @doc """
      returns list of atoms for design documents shows names
      """
      def shows(rec) do
        case rec.attrs[:shows] do
          nil -> nil
          shows   -> shows.keys()
        end
      end

    end
  end
end