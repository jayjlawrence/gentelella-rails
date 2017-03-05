class GentelellaAuthController < Devise::SessionsController

  before_action :authenticate_user!

  # Override the controller path to re-use the view files for the GentelellaController
  def self.controller_path
    @@_controller_path = 'gentelella'
  end

  # GET /gentelella/calendar
  def calendar
  end

  # GET /gentelella/chartjs
  def chartjs
  end

  # GET /gentelella/chartjs2
  def chartjs2
  end

  # GET /gentelella/contacts
  def contacts
  end

  # GET /gentelella/e_commerce
  def e_commerce
  end

  # GET /gentelella/echarts
  def echarts
  end

  # GET /gentelella/fixed_footer
  def fixed_footer
  end

  # GET /gentelella/fixed_sidebar
  def fixed_sidebar
  end

  # GET /gentelella/form
  def form
  end

  # GET /gentelella/form_advanced
  def form_advanced
  end

  # GET /gentelella/form_buttons
  def form_buttons
  end

  # GET /gentelella/form_upload
  def form_upload
  end

  # GET /gentelella/form_validation
  def form_validation
  end

  # GET /gentelella/form_wizards
  def form_wizards
  end

  # GET /gentelella/general_elements
  def general_elements
  end

  # GET /gentelella/glyphicons
  def glyphicons
  end

  # GET /gentelella/icons
  def icons
  end

  # GET /gentelella/inbox
  def inbox
  end

  # GET /gentelella/index
  def index
  end

  # GET /gentelella/index2
  def index2
  end

  # GET /gentelella/index3
  def index3
  end

  # GET /gentelella/invoice
  def invoice
  end

  # GET /gentelella/level2
  def level2
  end

  # GET /gentelella/media_gallery
  def media_gallery
  end

  # GET /gentelella/morisjs
  def morisjs
  end

  # GET /gentelella/other_charts
  def other_charts
  end

  # GET /gentelella/plain_page
  def plain_page
  end

  # GET /gentelella/pricing_tables
  def pricing_tables
  end

  # GET /gentelella/profile
  def profile
  end

  # GET /gentelella/project_detail
  def project_detail
  end

  # GET /gentelella/projects
  def projects
  end

  # GET /gentelella/tables
  def tables
  end

  # GET /gentelella/tables_dynamic
  def tables_dynamic
  end

  # GET /gentelella/typography
  def typography
  end

  # GET /gentelella/widgets
  def widgets
  end

  private

end
