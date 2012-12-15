defmodule ApplicationRouter do
  use CouchGears.Router

  Code.require_file "../../logics/utils.ex", __FILE__

  get "/" do
    res = CouchGears.AppUtils.test()
    conn.resp_body(to_binary(res))
  end
end
