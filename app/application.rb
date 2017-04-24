class Application

  @@items = []

  attr_accessor :item

  def call(env)

    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item = req.path.split("/items/").last
      item_info = @@items.find { |i| i.name == item }

      if item_info == nil
        resp.write "Item not found"
        resp.status = 400
      else
        resp.write "#{item_info.price}"
        resp.status = 200
      end

    else
      resp.write "Route not found"
      resp.status = 404

    end

    resp.finish

  end

end
