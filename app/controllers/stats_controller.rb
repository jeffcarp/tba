class StatsController < ApplicationController

  before_filter :authenticate_admin, :only => [:index]

  def image
    stat = Stat.new(:user_id => params[:user_id], :action => 'open_email', :issue_id => params[:issue_id])
    stat.save
    redirect_to "/assets/1x1.gif"
  end

  # GET /stats
  # GET /stats.json
  def index
    @stats = Stat.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stats }
    end
  end

  def email

    @opens = Stat.where('action = ?', 'open_email').order('created_at DESC').limit(50)
    # @opens_grouped = Stat.where('action = ?', 'open_email').group('date(created_at)').order('created_at DESC').count
    @opens_grouped = User.group('date(created_at)').order('created_at DESC').count

    opens_data = []
    x_axis_labels = []
    index = 0
    min = 1000000
    max = 0
    @opens_grouped.each do |k,v|
      x_axis_labels << k #if index % 2 == 0
      opens_data << v
      index += 1
      min = v if v < min
      max = v if v > max
    end
    x_axis_labels.reverse!
    opens_data.reverse!

    @opens_chart = Gchart.line(:size => '600x250',
      :axis_with_labels => 'x,y',
      :axis_labels => [x_axis_labels.join('|'), "#{min}|#{(max+min)/2}|#{max}"],
      :bg => '00000000',
      :data => opens_data)

    puts "OPENS DATA"
    puts opens_data.inspect
    puts
    puts
    puts "X AXIS LABELS"
    puts x_axis_labels.join('|').inspect



    # lc.data "Trend 1", [5,4,3,1,3,5,6], '0000ff'
    # lc.data "Trend 2", [1,2,3,4,5,6], '00ff00'
    # lc.data "Trend 3", [6,5,4,3,2,1], 'ff0000'
    # lc.axis :y, :range => [0,6], :color => 'ff00ff', :font_size => 16, :alignment => :center
    # lc.axis :x, :range => [0,6], :color => '00ffff', :font_size => 16, :alignment => :center

  end
end
