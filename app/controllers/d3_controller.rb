class D3Controller < ApplicationController
  prepend_view_path Rails.root

  def index
    @files = Dir.glob("chapter*/*.html").sort
    if params[:figure]
      if params[:figure].starts_with?("chapter")
        params[:chapter] = /chapter(?<c>\d+)/.match(params[:figure])['c'].to_i
      end
    else
      params[:figure] = 'index'
    end

    respond_to do |format|
      format.html do
        result = render(template: "#{params[:figure]}.html", layout: !(false || params[:raw]))
        result = result.gsub!('d3.v3.min.js', 'https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.17/d3.js') || result
        result = result.gsub!('.select("body")', '.select(".col")') || result
        # result = result.gsub!(/(src=\")(?!\S*http|\/)([^"\s]+\")/, '\1https://cdn.rawgit.com/prusswan/d3ia/0715b2dd/\2') || result
        @chapter = "/chapter#{params[:chapter]}" if params[:chapter]
        result = result.gsub!(/(src=\")(?!\S*http|\/)([^"\s]+\")/, '\1https://cdn.rawgit.com/emeeks/d3_in_action_2/b1be4f52%{c}/\2' % {c: @chapter}) || result

        return result
      end

      format.any(:csv, :json, :geojson, :topojson) do
        send_data File.read("#{params[:figure]}.#{request.format.to_sym}")
      end

      format.js do
        send_data File.read("#{params[:figure]}.js"), type: 'application/javascript'
      end
    end
  end
end
