defmodule CouchGears.Mochiweb.Handler do
  @moduledoc """
  This module is responsible for proxy passing incoming requests from a Couch DB to a gear application
  directly and sends response back to the Couch DB.
  """

  @doc """
  Calls the gear app
  """
  def call(app, httpd, db_name) do
    conn = app.service(CouchGears.Mochiweb.Connection.new(app, httpd, db_name))

    if is_record(conn, CouchGears.Mochiweb.Connection) do
      case conn.state do
        :set   -> { :ok, conn.send() }
        :unset -> { :ok, conn.send(500, "Missing response", conn) }
        :sent  -> { :ok, "Already sent" }
      end
    else
      raise "Expected 'service/1' function to return a CouchGears.Mochiweb.Connection, got #{inspect(conn)}"
    end
  end


  # Couch DB httpd handlers

  @doc """
  This function invoked from Couch DB directly and behaves as a `httpd_db_handlers` handler
  Check the `CouchGears.Initializer` module details.
  """
  def handle_db_gears_req(httpd, db) do
    db_name = db_name(db)

    List.last Enum.map CouchGears.gears, fn(app) ->
      app_config = CouchGears.App.normalize_config(app)
      if app_config[:handlers][:dbs] == :all do
        call(app, httpd, db_name)
      else
        raise "Bad value for the :dbs options (enabled only :all)"
      end
    end
  end


  defp db_name(db), do: :erlang.element(15, db)

end