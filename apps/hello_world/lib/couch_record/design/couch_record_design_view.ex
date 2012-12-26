defmodule CouchRecord.Design.View do
  defmacro __using__(opts) do
    quote do
      def has_view?(rec) do
        rec.attr?(:views)
      end

      def has_view?(view, rec) do
        if rec.has_view? do
          case get_value_from_json(view, get_all_views(rec)) do
            :not_found -> false
            _ -> true
          end
        else
          false
        end
      end

      def views(rec) do
        key_to_atom(Keyword.keys(get_all_views(rec)))
      end

      def view_body(view, rec) do
        {body} = get_value_from_json(view, get_all_views(rec))
        body
      end

      def refresh_view_body(body, rec) do
        body = [{"views", {body}}] ++ remove_views(rec)
      end


      def get_all_views(rec) do
        {views_list} = rec.attrs[:views]
        views_list
      end

      defp remove_views(rec) do
        List.keydelete(rec.body, to_binary(:views), 0)
      end



    end
  end
end