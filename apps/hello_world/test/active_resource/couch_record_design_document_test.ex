Code.require_file "../../test_helper.exs", __FILE__
Code.require_file "../utils.exs", __FILE__

defmodule CouchRecordDesignDocumentTest do
  use ExUnit.Case, async: false

  @db CouchRecord.Db.new("labeled")
  @desing_document @db.get("_design/tracks")

  test :design? do
    assert @desing_document.design? == true
  end

  test :design_id do
    assert @desing_document.attrs[:_id] == "_design/tracks"
  end

  test :has_view? do
    assert @desing_document.has_view? == true
  end

  test :design_name do
    assert @desing_document.name == "tracks"
  end

  test :views do
    assert @desing_document.views ==  [:all,:any]
  end

  test :view_body do
    assert @desing_document.view_body(:all) == [{"map", "function(doc) { if (doc.type == 'track') emit(null, {_id: doc._id}) }"}]
  end

  test :create_view do
    create_design_document = @desing_document.create_view(:test, {"map", "function(doc) { if (doc.type == 'test') emit(null, {_id: doc._id}) }"})
    assert create_design_document.view_body(:test) == [{"map", "function(doc) { if (doc.type == 'test') emit(null, {_id: doc._id}) }"}]
  end

  test :update_view do
    update_desing_document = @desing_document.update_view(:all, {"map", "function(doc) { if (doc.type == 'album') emit(null, {_id: doc._id}) }"})
    assert update_desing_document.view_body(:all) == [{"map", "function(doc) { if (doc.type == 'album') emit(null, {_id: doc._id}) }"}]
  end

  test :delete_view do
    create_design_document = @desing_document.create_view(:test, {"map", "function(doc) { if (doc.type == 'test') emit(null, {_id: doc._id}) }"})
    assert create_design_document.has_view?(:test) == true
    create_design_document = create_design_document.delete_view(:test)
    assert create_design_document.has_view?(:test) == false
  end

  test :rename_view do
    create_design_document = @desing_document.create_view(:test, {"map", "function(doc) { if (doc.type == 'test') emit(null, {_id: doc._id}) }"})
    assert create_design_document.has_view?(:test) == true
    rename_disign_document = create_design_document.rename_view(:test, :rename_test)
    assert rename_disign_document.has_view?(:test) == false
    assert rename_disign_document.has_view?(:rename_test) == true
  end

end