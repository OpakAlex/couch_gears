defmodule CouchRecord.Design.Update do
  @moduledoc """
  Update functions for design documets
  """
  defmacro __using__([]) do
    quote do

      @doc """
      returns list of atoms for design documents updates names
      """
      def updates(rec) do
        rec.attrs[:updates]
      end
    end
  end
end