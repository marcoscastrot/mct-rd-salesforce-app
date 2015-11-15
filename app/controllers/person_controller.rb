require 'mct-rd-salesforce'

class PersonController < ApplicationController
	def index
		@leads = MctRdSalesforce::Lead.new.load(auth_params)
	end

	def show
	    @article = MctRdSalesforce::Lead.new.get(params[:id], auth_params)
	end

	def new
		@lead = Lead.new
	end

	def create
		lead = Lead.new(lead_params)

		@lead = lead

		if @lead.valid?
			MctRdSalesforce::Lead.new.create(auth_params, {
 				"name": lead.FirstName,
 				"lastName": lead.LastName,
 				"email": lead.Email,
 				"company": lead.Company,
 				"website": lead.Website,
 				"jobTitle": lead.Title,
 				"phone": lead.Phone,
 			})

			redirect_to root_path
		else
			render 'new' 		
		end
	end

	def edit
		lead = MctRdSalesforce::Lead.new.get(params[:id], auth_params)
		@leadId = lead.Id
		@lead = Lead.new(:id => lead.Id, :FirstName => lead.FirstName, :LastName => lead.LastName, :Email => lead.Email,
							:Company => lead.Company, :Website => lead.Website, :Title => lead.Title, :Phone => lead.Phone)
	end

	def update
		lead = Lead.new(lead_params)
	 	@lead = lead

		if @lead.valid?
			MctRdSalesforce::Lead.new.update(auth_params, {
				"id": params[:id],
				"name": lead.FirstName,
				"lastName": lead.LastName,
				"email": lead.Email,
				"company": lead.Company,
				"website": lead.Website,
				"jobTitle": lead.Title,
				"phone": lead.Phone,
			})

	    	redirect_to root_path
    	else
		 	@leadId = params[:id]
			render 'new' 	
		end
	end

	def destroy
		lead = MctRdSalesforce::Lead.new.destroy(params[:id], auth_params)
	 
		redirect_to root_path
	end

	private
		def auth_params
	    	{ "username" => "marcoscastrot@gmail.com", 
	    		"password" => "RdSale00", 
	    		"security_token" => "BEiWG5t5ksss9TYSsyKwX3AJ", 
	    		"client_id" => "3MVG9KI2HHAq33RzThySBJALGiShFAkW2FdKpRcLGv1HWskRFa4t_B6gusRM8bYvNAqenV21MHtsGa.ySEUNY", 
	    		"client_secret" => "3280416324043101337" 
	    	}
		end

	private
	  	def lead_params
	    	params.require(:lead).permit(:FirstName, :LastName, :Company, :Email, :Website, :Phone, :Title)
	  	end  	
end
