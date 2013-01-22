defmodule CouchRecord.Base.Common do
  @moduledoc """
  This module add common functions to CouchRecord.Base
  """

  @doc """
  converts proplist from couchdb document to HashDict type, add this as a second param to HashDict.new function
  """
  def from_list_to_dic do
    fn({key, value}) ->
      case value do
        {list_value} -> {binary_to_atom(key), HashDict.new(list_value, from_list_to_dic)}
                   _ -> {binary_to_atom(key), value}
      end
    end
  end
end