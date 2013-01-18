Code.require_file "../../test_helper.exs", __FILE__

defmodule CouchRecord.Design.CommonTest do
  use ExUnit.Case, async: false

  alias CouchRecord.Design.Common, as: Subject

  test :from_list_to_dic do
    assert HashDict.new([{"a", 1}, {"b", 2}, {"d", {[{"c", 3}]}}], Subject.from_list_to_dic) ==  HashDict.new([a: 1, b: 2, d: HashDict.new([c: 3])])

    view = [{"map", "function(doc) { if (doc.type == 'track') emit(null, {_id: doc._id}) }"}]
    list = [{"a", 1},{"views",{[{"test", {view}}]}}]

    assert HashDict.new(list, Subject.from_list_to_dic) ==  HashDict.new([a: 1, views: HashDict.new([test: {view}])])

  end

end