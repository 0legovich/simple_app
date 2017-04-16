module SessionsHelper

	def sign_in(user)
		remember_token = User.new_remember_token #создаем новый токен
		cookies.permanent[:remember_token] = remember_token #помещаем зашифрованый токен в куки брайзера
		user.update_attribute(:remember_token, User.encrypt(remember_token)) #сохраняем зашифрованый токен в БД
		self.current_user = user #Устанавливаем текущего пользователя равным данному пользователю
	end

	def signed_in?
		!current_user.nil?
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		remember_token = User.encrypt(cookies[:remember_token])
		@current_user ||= User.find_by(remember_token: remember_token)
	end

	def current_user?(user)
    	user == current_user
  	end

  	def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Пожалуйста войдите!"
      end
    end

	def sign_out
		current_user.update_attribute(:remember_token, User.encrypt(User.new_remember_token))
		cookies.delete(:remember_token)
		self.current_user = nil
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.url if request.get?
	end
end
