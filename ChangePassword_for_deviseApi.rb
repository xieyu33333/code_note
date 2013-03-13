if current_user.update_with_password({:current_password => params[:current_password], :password => params[:password]})
  current_user.reset_authentication_token!
  present current_user, :with => APIEntities::User
else
  present current_user, :with => APIEntities::UserError
end


api接口中的应用，需要：
gem 'grape'
gem 'grape-entity'
