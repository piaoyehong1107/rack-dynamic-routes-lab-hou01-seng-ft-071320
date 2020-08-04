class Application
  def call(env)
    resp=Rack::Response.new 
    req=Rack::Request.new(env)
    
    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
      name_list=[]
      @@items.each {|x|name_list.push(x.name)}
      if name_list.include?(item_name)
        item_found=@@items.find{|x|x.name==item_name}
        resp.write item_found.price
      else
        resp.write "Item not found"
        resp.status=400
      end
    else
      resp.write "Route not found"
      resp.status=404
    end
    resp.finish
  end
end