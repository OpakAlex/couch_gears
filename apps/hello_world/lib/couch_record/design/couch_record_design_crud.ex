defmodule CouchRecord.Design.CRUD do
  defmacro __using__(opts) do
    quote do

      def put(:view, view, value, rec) do
        unless rec.has_view? do
          rec = rec.put([views: {[]}])
        end
        if rec.has_view?(view) do
          update(:view, view, value, rec)
        else
          create(:view, view, value, rec)
        end
      end

      def put(:show, key, value, rec) do

      end

      def put(:list, key, value, rec) do

      end


      def remove(:view, view, rec) do
        body = List.keydelete(get_all_views(rec), to_binary(view), 0)
        save_record(refresh_view_body(body, rec), rec)
      end

      def rename(:view, view, new_name, rec) do
        [view_body | t] = rec.view_body(view)
        rec = rec.remove(:view, view)
        rec.put(:view, new_name, view_body)
      end


      #view CRUD
      defp create(:view, view, value, rec) do
        body = get_all_views(rec)
        body = body ++ [{to_binary(view), {[value]}}]
        save_record(refresh_view_body(body, rec), rec)
      end

      defp update(:view, view, value, rec) do
        body = List.keydelete(get_all_views(rec), to_binary(view), 0)
        body = body ++ [{to_binary(view), {[value]}}]
        save_record(refresh_view_body(body, rec), rec)
      end

    end
  end
end