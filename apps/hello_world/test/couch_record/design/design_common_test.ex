Code.require_file "../../../test_helper.exs", __FILE__

defmodule CouchRecord.Base.CommonTest do
  use ExUnit.Case, async: false

  @db CouchRecord.Db.new("labeled")
  @desing_document @db.get("_design/tracks")

  test :from_list_to_dic do
    assert HashDict.new([{"a", 1}, {"b", 2}, {"d", {[{"c", 3}]}}], @desing_document.from_list_to_dic()) ==  HashDict.new([a: 1, b: 2, d: HashDict.new([c: 3])])

    view = [{"map", "function(doc) { if (doc.type == 'track') emit(null, {_id: doc._id}) }"}]
    list = [{"a", 1},{"views",{[{"test", {view}}]}}]

    assert HashDict.new(list, @desing_document.from_list_to_dic()) ==  HashDict.new([a: 1, views: HashDict.new([test: {view}])])

  end

end