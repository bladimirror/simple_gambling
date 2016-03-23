class RpgController < ApplicationController
  def index
    puts "Checking session[:status]...%s" % [session[:status]]
    game_settings if session[:status] != true

    puts "Loading INDEX page..."
    render "index"
  end

  def farm
    puts "Getting gold from the FARM..."
    session[:div_color_cave] = "ninja_gold"
    session[:div_color_house] = "ninja_gold"
    session[:div_color_casino] = "ninja_gold"
    session[:div_color_farm] = "won_gold"
    roll = rand(10..20).round
    session[:gold] = session[:gold] + roll
    session[:activity].push( ("You won %s pieces of gold from the %s. -- %s" % [roll, "farm", session[:time]]).to_s )
    redirect_to "/"
  end

  def cave
    puts "Getting gold from the CAVE..."
    session[:div_color_farm] = "ninja_gold"
    session[:div_color_house] = "ninja_gold"
    session[:div_color_casino] = "ninja_gold"
    session[:div_color_cave] = "won_gold"
    roll = rand(5..10).round
    session[:gold] = session[:gold] + roll
    session[:activity].push( ("You won %s pieces of gold from the %s. -- %s" % [roll, "cave", session[:time]]).to_s )
    redirect_to "/"
  end

  def house
    puts "Getting gold from the house..."
    session[:div_color_farm] = "ninja_gold"
    session[:div_color_cave] = "ninja_gold"
    session[:div_color_casino] = "ninja_gold"
    session[:div_color_house] = "won_gold"
    roll = rand(2..5).round
    session[:gold] = session[:gold] + roll
    session[:activity].push( ("You won %s pieces of gold from the %s. -- %s" % [roll, "house", session[:time]]).to_s )
    redirect_to "/"
  end

  def casino
    puts "Getting gold from the CASINO..."
    session[:div_color_farm] = "ninja_gold"
    session[:div_color_cave] = "ninja_gold"
    session[:div_color_house] = "ninja_gold"
    gamble = rand(0..100).round
    roll = rand(0..50).round
    if gamble > 50
      session[:div_color_casino] = "won_gold"
      session[:gold] = session[:gold] + roll
      session[:activity].push( ("You won %s pieces of gold from the %s. -- %s" % [roll, "casino", session[:time]]).to_s )
    else
      session[:div_color_casino] = "lost_gold"
      session[:gold] = session[:gold] - roll
      session[:activity].push( ("You lost %s pieces of gold from the %s. -- %s" % [roll, "casino", session[:time]]).to_s )
    end
    redirect_to "/"
  end

  def new_game
    puts "Clearing game session..."
    session.clear
    redirect_to "/"
  end

  def game_settings
    puts "Loading new game settings..."
    session[:status] = true
    session[:div_color_farm] = "ninja_gold"
    session[:div_color_cave] = "ninja_gold"
    session[:div_color_house] = "ninja_gold"
    session[:div_color_casino] = "ninja_gold"
    session[:activity] = []
    session[:time] = Time.new
    session[:gold] = 0
  end
end