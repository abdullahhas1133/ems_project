# frozen_string_literal: true

Rails.application.configure do
  config.session_store :cookie_store, key: '_project_session', expire_after: 2.years
end
