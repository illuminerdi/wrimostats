class WordWarsController < ApplicationController
  # GET /word_wars
  # GET /word_wars.xml
  def index
    @word_wars = WordWar.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @word_wars }
    end
  end

  # GET /word_wars/1
  # GET /word_wars/1.xml
  def show
    @word_war = WordWar.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @word_war }
    end
  end

  # GET /word_wars/new
  # GET /word_wars/new.xml
  def new
    @word_war = WordWar.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @word_war }
    end
  end

  # GET /word_wars/1/edit
  def edit
    @word_war = WordWar.find(params[:id])
  end

  # POST /word_wars
  # POST /word_wars.xml
  def create
    @word_war = WordWar.new(params[:word_war])

    respond_to do |format|
      if @word_war.save
        flash[:notice] = 'WordWar was successfully created.'
        format.html { redirect_to(@word_war) }
        format.xml  { render :xml => @word_war, :status => :created, :location => @word_war }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @word_war.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /word_wars/1
  # PUT /word_wars/1.xml
  def update
    @word_war = WordWar.find(params[:id])

    respond_to do |format|
      if @word_war.update_attributes(params[:word_war])
        flash[:notice] = 'WordWar was successfully updated.'
        format.html { redirect_to(@word_war) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @word_war.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /word_wars/1
  # DELETE /word_wars/1.xml
  def destroy
    @word_war = WordWar.find(params[:id])
    @word_war.destroy

    respond_to do |format|
      format.html { redirect_to(word_wars_url) }
      format.xml  { head :ok }
    end
  end
end
