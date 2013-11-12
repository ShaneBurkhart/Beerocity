class RegistrationsController < Devise::RegistrationsController

  def new
    @plan = Role.find_by_name "basic"
    @recipe = Recipe.current_recipe
    super
  end

  protected

    def after_update_path_for(resource)
      content_path
    end

  private

    def build_resource(*args)
      super
      if params[:plan]
        resource.add_role(params[:plan])
      end
    end

end
