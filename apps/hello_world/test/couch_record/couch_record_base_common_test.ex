Code.require_file "../../test_helper.exs", __FILE__
Code.require_file "../utils.exs", __FILE__

defmodule CouchRecord.Base.CommonTest do
  use ExUnit.Case, async: false

  test :key_to_atom do
    assert CouchRecord.Base.Common.key_to_atom(["_id","_rev"]) == [:_rev,:_id]
  end

end
