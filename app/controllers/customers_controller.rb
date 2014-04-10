class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /customers
  # GET /customers.json
  def index
    require 'pp'

pp ['REF:' + request.referer.to_s]
    @total_count = Customer.all.size
    @customers = Customer.includes(:bank)
    @conditions = params[:conditions] || session[:customer_conditions] || {}
    @keyword = @conditions[:keyword];

    session[:customer_conditions] = @conditions if @conditions.present?

    # Basic conditions.
    if (@conditions[:keyword].present?)
pp '+++++' + @conditions[:keyword]
#      @conditions[:keyword].split(' ') do |word|
      word = @conditions[:keyword]
pp '@@@@@'
        kwd = '%' + word.gsub(/[!%_]/) { |x| '!' + x } + '%'
pp kwd
        whr = []
        %w(accountid fullname banks.bankname parentid).each do |col|
          whr.push("#{col} like '#{kwd}' escape '!'")
        end
pp '*****'
pp whr
        @customers = @customers.where(whr.join(" or "))
#      end
    else
      if (@conditions[:multipleid].present?)
pp @conditions[:multipleid].split("\r\n")
        word = " accountid in ('" + @conditions[:multipleid].split("\r\n").join("', '") + "')"
        @customers = @customers.where(word)
      end
    end

    # Optional conditions.
    # Get only incomplete data.
    if (@conditions[:incomplete].present? and @conditions[:incomplete] == 'true')

      whr = []
      %w(accountid fullname banks.bankname banks.branchname banks.swiftcode banks.address).each do |col|
        whr.push("#{col} is null")
      end
      @customers = @customers.where(whr.join(" or "))
    end
    @retrieve_count = @customers.size

    # Show all customers.
    if (@conditions[:removelimit].blank? or @conditions[:removelimit] != 'true')
      @customers = @customers.limit(100)
    end
    @display_count = @customers.size

    respond_to do |format|
      format.html
      format.csv { send_data @customers.to_csv, type: 'text/csv; charset=shift_jis', filename: "customers_#{Time.now.strftime('%Y%m%d%H%M%S')}.csv" }
    end
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
  end

  # GET /customers/1/prev
  def prev
    @customer = Customer.find(params[:id]).prev
    if @customer.present?
      redirect_to "/customers/#{@customer.id}/" 
    else
     #render :template => "customers/show", :locals => {:customer => @customer}
     @customer = Customer.first
     redirect_to "/customers/#{@customer.id}/"
   end
  end

  # GET /customers/1/next
  def next
    @customer = Customer.find(params[:id]).next
    if @customer.present?
      redirect_to "/customers/#{@customer.id}/" 
      #render :template => "customers/show", :locals => {:customer => @customer}
    else
      @customer = Customer.last
      redirect_to "/customers/#{@customer.id}/"
    end
  end

  # GET /customers/new
  def new
    @customer = Customer.new
    @banks = Bank.all.order('bankname, branchname')
  end

  # GET /customers/1/edit
  def edit
    @customer = Customer.find(params[:id], :include => :attachments, :order => "attachments.created_at")
    @attaches = Attachment.all.where('customer_id=?',(params[:id]))
  end

  # GET /customers/password
  # GET /customers/password.json
  def password
    respond_to do |format|
      format.html
      format.json { render json: { :password => get_password } }
    end
  end

  # POST /customers
  # POST /customers.json
  def create

    @customer = Customer.new(customer_params)

    if @customer.bank_id.blank?
      if bank_params.present?
        @bank = Bank.new(bank_params)
        bank_save = @bank.save
      else 
        bank_save = false
      end
    else
      #@bank = Bank.find(@customer.bank_id)
      #bank_save = (@bank.present?) ? true : false
      bank_save = true
    end

    if bank_save
      @customer.bank_id = @bank.id if @customer.bank_id.blank?

      respond_to do |format|
        if @customer.save
          format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
          format.json { render action: 'show', status: :created, location: @customer }
        else
          format.html { render action: 'new' }
          format.json { render json: @customer.errors, status: :unprocessable_entity }
        end
      end
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    _c_params = customer_params
    if @customer.bank_id.blank? and bank_params.present?
      @bank = Bank.new(bank_params)
      @bank.save
      @customer.bank_id = @bank.id
      _c_params[:bank_id] = @bank.id
    end
pp _c_params

    respond_to do |format|
      if @customer.update(_c_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.includes(:bank).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:accountid, :userclass, :fullname, :password, :zipcode, :address, :country, :birthday, :sex, :nationality, :tel, :fax, :mobile, :email, :parentid, :bank_id, :holderid, :service1, :service2, :cbc)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bank_params
      params.require(:bank).permit(:bankname, :branchname, :bankcodee, :branchcode, :swiftcode, :address, :bankcode, :branchcode)
    end
end
