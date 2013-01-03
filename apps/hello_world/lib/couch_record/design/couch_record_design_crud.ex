defmodule CouchRecord.Design.CRUD do
  defmacro __using__([]) do
    quote do

      def put(type, name, value, rec) do
        unless rec.exist?(type) do
          rec = rec.put(type, {[]})
        end
        if rec.exist?(type, name) do
          update(type, name, value, rec)
        else
          create(type, name, value, rec)
        end
      end

      def remove(type, item, rec) do
        body = List.keydelete(content(type, rec), to_binary(item), 0)
        apply_changes(refresh_body(type, body, rec), rec)
      end

      def rename(type, item, new_name, rec) do
        [view_body | t] = rec.body(type, item)
        rec = rec.remove(type, item)
        rec.put(type, new_name, view_body)
      end

      #private
      defp create(type, item, value, rec) do
        body = content(type, rec)
        body = body ++ [{to_binary(item), {[value]}}]
        apply_changes(refresh_body(type, body, rec), rec)
      end

      defp update(type, item, value, rec) do
        body = List.keydelete(content(type, rec), to_binary(item), 0)
        body = body ++ [{to_binary(item), {[value]}}]
        apply_changes(refresh_body(type, body, rec), rec)
      end

    end
  end
end