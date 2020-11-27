class ApplicationController < ActionController::Base
    def content_not_found
        render file: "#{Rails.root}/public/404", layout: true, status: :not_found
    end
end
