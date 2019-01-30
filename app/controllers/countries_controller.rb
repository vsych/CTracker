class CountriesController < ApplicationController
  # GET /countries
  def index
    @countries = Country.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /countries/1
  def show
    @country = Country.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def visit
    @country = Country.find(params[:id])

    respond_to do |format|
      if current_user.visited?(@country)
        message = "Country was successfully marked as not visited"
        status = "Not Visited"
      else
        message = "Country was successfully marked as visited"
        status = "Visited"
      end

      current_user.toggle_visiting(@country)
      format.html { redirect_to(countries_path, :flash => { :notice => message }) }
      format.json { render :json => {
          :message => message,
          :status => status,
          :"Visited" => current_user.countries.count,
          :"Not Visited" => Country.count - current_user.countries.count
        }
      }
    end
  end

  def statistic
    user_countries = UserCountry.user_statistic(current_user)
    respond_to do |format|
      format.json{ render :json => {
          :collection => user_countries
        }
      }
    end
  end

end
