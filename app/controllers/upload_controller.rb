class UploadController < ApplicationController
  def upload
    response.headers["Content-type"] = "text/plain; charset=UTF-8"
    response.headers["Expires"] = "Mon, 26 Jul 1997 05:00:00 GMT"
    response.headers["Cache-control"] = "no-store, no-cache, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    
    render :json => {:jsonrpc => "2.0", :result => nil, :id => "id"}
    return
  end
end
