class DriversLicensesController< ApplicationController
  def index
  	@drivers_license = DriversLicense.all
  end	
end
