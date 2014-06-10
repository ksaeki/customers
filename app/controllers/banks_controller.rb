class BanksController < ApplicationController
  before_action :set_bank, only: [:show, :edit, :update, :destroy]

  # GET /banks
  # GET /banks.json
  def index
    require 'pp'
    #@banks = Bank.all
    @banks = Bank.includes(:branches)
    #@banks = Bank.select("count(*) as cnt, bankname, bankcode").group(:bankname, :bankcode)

    @conditions = params[:conditions] || session[:bank_conditions] || {}
    @order = params[:order] || session[:bank_order] || {column: '', type: ''}
    @keyword = @conditions[:keyword];

    session[:bank_conditions] = @conditions if @conditions.present?
    session[:bank_order]      = @order      if @order.present?

    @total_count = @banks.length
    if (@keyword.present?)
        kwd = '%' + @keyword.gsub(/[!%_]/) { |x| '!' + x } + '%'
        whr = []
        ["bankname", "branchname", "swiftcode", "address"].each do |col|
          if (col == "bankcode" or col == "branchcode")
            whr.push("convert(#{col}, CHAR) like '#{kwd}' escape '!'")
          else
            whr.push("#{col} like '#{kwd}' escape '!'")
          end
        end
        @banks = @banks.where(whr.join(" or "))
    end

    # Optional conditions.
    # Get only incomplete data.
    if (@conditions[:incomplete].present? and @conditions[:incomplete] == 'true')

      whr = []
      %w(bankname branchname swiftcode address).each do |col|
        whr.push("#{col} is null")
      end
      @banks = @banks.where(whr.join(" or "))
    end

    @retrieve_count = @banks.length
    # Set an order.
    if (@order.present?)
      @banks = @banks.order(@order[:column] + ' ' + @order[:type])
    end

    # Show all banks.
    if (@conditions[:removelimit].blank? or @conditions[:removelimit] != 'true')
      @banks = @banks.limit(100)
    end
    @display_count = @banks.length

    respond_to do |format|
      format.html
      format.csv { send_data @banks.to_csv, type: 'text/csv; charset=shift_jis', filename: "banks_#{Time.now.strftime('%Y%m%d%H%M%S')}.csv" }
    end
  end

  # POST /banks/branches
  # POST /banks/branches.json
  def branches
    bankname = params[:bankname]
    bankcode = params[:bankcode]
    bankcode = nil if bankcode.blank? 
pp [bankname,bankcode]
    @banks = Bank.find_all_by_bankname_and_bankcode(bankname, bankcode)

  end

  # GET /banks/1
  # GET /banks/1.json
  def show
  end

  # GET /banks/search
  # GET /banks/search.json
  def search
  require "pp"
    fields = {}
    fields[:bankname]   = params[:bankname]   if params[:bankname].present? 
    fields[:branchname] = params[:branchname] if params[:branchname].present? 
    fields[:bankcode]   = params[:bankcode]   if params[:bankcode].present? 
    fields[:branchcode] = params[:branchcode] if params[:branchcode].present? 
    fields[:swiftcode]  = params[:swiftcode]  if params[:swiftcode].present? 
    fields[:address]    = params[:address]    if params[:address].present? 
    
    #@banks = Bank.search_or(fields)
    @banks = Bank.search_and(fields)
  end

  # GET /banks/new
  def new
    @bank = Bank.new
  end

  # GET /banks/1/edit
  def edit
  end

  # POST /banks
  # POST /banks.json
  def create
    @bank = Bank.new(bank_params)

    respond_to do |format|
      if @bank.save
        format.html { redirect_to @bank, notice: 'Bank was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bank }
      else
        format.html { render action: 'new' }
        format.json { render json: @bank.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /banks/1
  # PATCH/PUT /banks/1.json
  def update
    respond_to do |format|
      if @bank.update(bank_params)
        format.html { redirect_to @bank, notice: 'Bank was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bank.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /banks/1
  # DELETE /banks/1.json
  def destroy
    Customer.where('bank_id = ?', @bank.id).update_all(:bank_id => nil)
    @bank.destroy
    respond_to do |format|
      format.html { redirect_to banks_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_bank
    @bank = Bank.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def bank_params
    params.require(:bank).permit(:bankname, :branchname, :bankcodee, :branchcode, :holdername, :swiftcode, :address)
  end
end
