module FoodsHelper
  
  def placecolor(food)
    if food.place == "冷蔵"
      "#1bf"
    elsif food.place == "冷凍"
      "#03f"
    elsif food.place == "室温"
      ""
    else 
      "#eee"
    end
  end
end
