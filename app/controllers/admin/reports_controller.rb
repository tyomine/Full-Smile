class Admin::ReportsController < ApplicationController
  
  def index
    @reports = Report.page(params[:page]).order(created_at: :desc)
    
  end

  def show
    @report = Report.find(params[:id])
  end
  
  def update
    @report = Report.find(params[:id])
    if @report.update(report_params)
      flash[:notice] = "対応ステータスを更新しました。"
      redirect_to edit_admin_user_path(@report.reported)
    end
  end
  
  private
  
  def report_params
    params.require(:report).permit(:status)
  end  
end
