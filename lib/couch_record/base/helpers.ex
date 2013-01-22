defmodule CouchRecord.Base.Helpers do
  @moduledoc """
  helpers mixins uses for CouchRecord.Document and CouchRecord.Design.Documetn
  """

  @doc """
  returns atoms list from binaries list
  """
  def key_to_atom([], acc) do
    acc
  end

  def key_to_atom([h|t], acc) do
    key_to_atom(t, [to_atom(h) | acc])
  end

  def key_to_atom(keys) do
    key_to_atom(keys, [])
  end

  @doc """
  return touple with binary keys from HashDict
  """
  def dict_to_list(dict) do
    Enum.map dict.keys(), fn(el) ->
      element = dict[el]
      case is_hash_dict?(element) do
        true -> {to_binary(el), {dict_to_list(element)}}
        false -> {to_binary(el), element}
      end
    end
  end

  @doc """
  alias for Enum.any?
  """

  def include?(array, value) do
    Enum.any?(array, fn(x) -> x == value end)
  end

  @doc """
  returns atom from binary, atom
  """
  def to_atom(value) do
    case is_atom(value) do
      true -> value
      false -> binary_to_atom(value)
    end
  end

  @doc """
  returns true when HashDict else - false
  """
  def is_hash_dict?(value) do
    case value do
      {HashDict, _} -> true
      _ -> false
    end
  end

  def is_design?(id) do
    Regex.match?(%r/^_design/, id)
  end

end
