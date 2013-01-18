defmodule CouchRecord.Design.Common do
  @moduledoc """
  This module add common functions to CouchRecord.Design.Base
  """

  @doc """
  This function convert proplist from couchdb design document to HashDict type, add this as a second param to HashDict.new function
  Fields views, lists, shows, updates are not recursion.
  ! Warn this is recursion function
  """

  def from_list_to_dic do
    fn({key, value}) ->
      case value do
        {list_value} ->
          if design_key?(key) do
            {binary_to_atom(key), HashDict.new(list_value, from_list_to_dic_last)}
          else
            {binary_to_atom(key), HashDict.new(list_value, from_list_to_dic)}
          end
        _ -> {binary_to_atom(key), value}
      end
    end
  end

  @doc """
  this function check for system fields in design document
  """
  def design_key?(key) do
    (key == "views" || key == "lists" || key == "shows" || key == "updates")
  end

  @doc """
  This is not recursion from_list_to_dic function, use only as private function
  """
  def from_list_to_dic_last do
    fn({key, value}) ->
      {binary_to_atom(key), value}
    end
  end
end