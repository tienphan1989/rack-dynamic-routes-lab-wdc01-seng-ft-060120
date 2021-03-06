# 1. Your application should only accept the `/items/<ITEM NAME>` route. 
# Everything else should `404`
#   2. If a user requests `/items/<Item Name>` 
#   it should return the price of that item
#   3. IF a user requests an item that you 
#   don't have, then return a `400` and an error message

class Application
 
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
 
    if req.path.match(/items/)
        item_search = req.path.split("/items/").last
        if item = @@items.find {|item| item.name == item_search}
            resp.write item.price
            resp.status = 200
        else    
            resp.write "Item not found"
            resp.status = 400  
        end
    else
      resp.write "Route not found"
      resp.status = 404
    end
 
    resp.finish
  end
end