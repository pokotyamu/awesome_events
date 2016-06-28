module LoginHelper
  def setup(user,logged_in)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    allow_any_instance_of(ApplicationController).to receive(:logged_in?).and_return(logged_in)
  end
end
