# frozen_string_literal: true

class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @posts = Post.page(params[:page]).order(created_at: :desc)
  end
end
