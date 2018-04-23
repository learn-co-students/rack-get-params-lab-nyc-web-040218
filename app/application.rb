class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)

      search_item = req.params["q"]

      if @@items.include?(search_item)
        resp.write "#{search_item} is one of our items"
      else
        resp.write "Couldn't find #{search_item}"
      end
    elsif req.path.match(/add/)
      search_item = req.params["item"]

      if @@items.include?(search_item)
        @@cart.push(search_item)
        resp.write "added #{search_item}"
      else
        resp.write "We don't have that item"
      end
    elsif req.path.match(/cart/)
      if @@cart.empty?
        resp.write "Your cart is empty"
      end

      @@cart.each do |item|
        resp.write "#{item}\n"
      end
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end
end
