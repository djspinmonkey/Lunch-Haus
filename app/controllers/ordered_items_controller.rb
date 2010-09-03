class OrderedItemsController < ApplicationController
  before_filter :authenticate_user!

  # GET /ordered_items
  # GET /ordered_items.xml
  def index
    @ordered_items = OrderedItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ordered_items }
    end
  end

  # GET /ordered_items/1
  # GET /ordered_items/1.xml
  def show
    @ordered_item = OrderedItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ordered_item }
    end
  end

  # GET /ordered_items/new
  # GET /ordered_items/new.xml
  def new
    @ordered_item = OrderedItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ordered_item }
    end
  end

  # GET /ordered_items/1/edit
  def edit
    @ordered_item = OrderedItem.find(params[:id])
  end

  # POST /ordered_items
  # POST /ordered_items.xml
  def create
    @ordered_item = OrderedItem.new(params[:ordered_item])

    respond_to do |format|
      if @ordered_item.save
        format.html { redirect_to(@ordered_item, :notice => 'Ordered item was successfully created.') }
        format.xml  { render :xml => @ordered_item, :status => :created, :location => @ordered_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ordered_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ordered_items/1
  # PUT /ordered_items/1.xml
  def update
    @ordered_item = OrderedItem.find(params[:id])

    respond_to do |format|
      if @ordered_item.update_attributes(params[:ordered_item])
        format.html { redirect_to(@ordered_item, :notice => 'Ordered item was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ordered_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ordered_items/1
  # DELETE /ordered_items/1.xml
  def destroy
    @ordered_item = OrderedItem.find(params[:id])
    @ordered_item.destroy

    respond_to do |format|
      format.html { redirect_to(ordered_items_url) }
      format.xml  { head :ok }
    end
  end
end
