Code.require_file "../../../test_helper.exs", __FILE__

defmodule CouchRecord.Base.CommonTest do
  use ExUnit.Case, async: false

  @db CouchRecord.Db.new("labeled")
  @document @db.get("medianet:album:100049")

  test :from_list_to_dic do
    assert HashDict.new([{"a", 1}, {"b", 2}], @document.from_list_to_dic()) ==  HashDict.new([a: 1, b: 2])
    assert HashDict.new([{"a", 1}, {"b", 2}, {"d", {[{"c", 3}]}}], @document.from_list_to_dic()) ==  HashDict.new([a: 1, b: 2, d: HashDict.new([c: 3])])
  end

end