class DesignersController < ApplicationController

  def new
    @designer = Designer.new
  end

  def create
    @designer = Designer.new(create_params)
    if @designer.save
      redirect_to created_designers_path
    else
      redirect_to not_created_designers_path
    end
  end

  def created

  end

  def not_created

  end

  private
  def create_params
    params.require(:designer).permit(:firstname, :lastname, :email, :city, :country, :website_url, :comment, :file_1, :file_2, :file_3, :phone_number)
  end
end
