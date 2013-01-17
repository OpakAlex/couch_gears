defmodule CouchRecord.Base.Save do
    defmacro __using__([]) do
      quote do

        def save!(rec) do
          case rec.save do
            false -> raise SaveError
            _ -> true
          end
        end

        def save(rec) do
          case CouchRecord.Db.save!(rec.db_name, rec.to_json()) do
            :ok -> rec
            _ -> false
          end
        end

      end
    end
end