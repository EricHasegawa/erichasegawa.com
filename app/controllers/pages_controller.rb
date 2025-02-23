class PagesController < ApplicationController
  allow_unauthenticated_access only: [ :home ]
  before_action :resume_session, only: [ :home ]

  def home
  end
end
