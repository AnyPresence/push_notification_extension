
class ActionController::Base
  def authenticate_admin!
  end
end

class ActionDispatch::Routing::RoutesProxy
  def admin_root_path
    ""
  end
  
  def admin_extensions_path
    ""
  end
end