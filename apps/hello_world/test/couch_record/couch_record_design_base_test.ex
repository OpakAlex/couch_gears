Code.require_file "../../test_helper.exs", __FILE__
Code.require_file "../utils.exs", __FILE__

defmodule CouchRecordDesignBaseTest do
  use ExUnit.Case, async: false

  @db CouchRecord.Db.new("labeled")
  @desing_document @db.get("_design/tracks")

  test :design? do
    assert @desing_document.design? == true
  end

  test :exist? do
    assert @desing_document.exist?(:view) == true
  end

  test :design_id do
    assert @desing_document.attrs[:_id] == "_design/tracks"
  end

  test :design_name do
    assert @desing_document.name == "tracks"
  end

  test :body do
    assert @desing_document.body(:show, :one) == [{"map", "function(doc) { if (doc.type == 'track') emit(null, {_id: doc._id}) }"}]
  end

  test :create do
    create_design_document = @desing_document.put(:show, :test, {"map", "function(doc) { if (doc.type == 'test') emit(null, {_id: doc._id}) }"})
    assert create_design_document.body(:show, :test) == [{"map", "function(doc) { if (doc.type == 'test') emit(null, {_id: doc._id}) }"}]
  end

  test :update do
    update_desing_document = @desing_document.put(:show, :one, {"map", "function(doc) { if (doc.type == 'album') emit(null, {_id: doc._id}) }"})
    assert update_desing_document.body(:show, :one) == [{"map", "function(doc) { if (doc.type == 'album') emit(null, {_id: doc._id}) }"}]
  end

  test :remove do
    create_design_document = @desing_document.put(:view, :test, {"map", "function(doc) { if (doc.type == 'test') emit(null, {_id: doc._id}) }"})
    assert create_design_document.exist?(:view, :test) == true
    create_design_document = create_design_document.remove(:view, :test)
    assert create_design_document.exist?(:view, :test) == false
  end

  test :rename do
    create_design_document = @desing_document.put(:show, :test, {"map", "function(doc) { if (doc.type == 'test') emit(null, {_id: doc._id}) }"})
    assert create_design_document.exist?(:show, :test) == true
    rename_disign_document = create_design_document.rename(:show, :test, :rename_test)
    assert rename_disign_document.exist?(:show, :test) == false
    assert rename_disign_document.exist?(:show, :rename_test) == true
  end

end