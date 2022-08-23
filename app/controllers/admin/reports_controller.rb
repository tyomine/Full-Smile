# frozen_string_literal: true

class Admin::ReportsController < ApplicationController
  before_action :authenticate_admin!

  def index
    reports = Report.all
    reports.each { |report| report.update(is_checked: true) }
    @reports = reports.page(params[:page]).order(created_at: :desc)
  end

  def show
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:id])
    if @report.update(report_params)
      flash[:notice] = "対応ステータスを更新しました。"
      redirect_to admin_reports_path
    end
  end

  private
    def report_params
      params.require(:report).permit(:status)
    end
end
