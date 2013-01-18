Code.require_file "../../test_helper.exs", __FILE__

defmodule CouchRecord.Base.HelpersTest do
  use ExUnit.Case, async: false
  alias CouchRecord.Base.Helpers, as: Subject


  test :key_to_atom do
    assert Subject.key_to_atom(["_id","_rev"]) == [:_rev,:_id]
  end

  test :to_atom do
    assert Subject.to_atom("test") == :test
    assert Subject.to_atom("test") != "test"

    assert Subject.to_atom(:test) == :test
  end

  test :is_hash_dict? do
    assert Subject.is_hash_dict?(HashDict.new([])) == true
    assert Subject.is_hash_dict?(:atom) == false
    assert Subject.is_hash_dict?("string") == false
  end

  test :include? do
    assert Subject.include?([:a, :b, :c], :a) == true
    assert Subject.include?([:a, :b, :c], :d) == false
  end

  test :to_list_binary do
    dict = HashDict.new([a: 1, b: 2, c: 3])
    assert Subject.dict_to_list(dict) == [{"a",1},{"b",2},{"c",3}]

    dict = HashDict.new([a: 1, b: 2, c: HashDict.new([d: 3])])
    assert Subject.dict_to_list(dict) == [{"a", 1}, {"b", 2}, {"c", {[{"d", 3}]}}]
  end

end
