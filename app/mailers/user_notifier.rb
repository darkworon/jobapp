# encoding: utf-8
class UserNotifier < ActionMailer::Base
  default from: "Job4Fun <noreply@job4fun.ru>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.activation_notifier.activation.subject
  #
  def signup(activation)
    I18n.locale = "ru"
    @activation = activation
    mail to: @activation.user.email, subject: "Активация аккаунта"
    #puts "Sended to #{@activation.user.email}"
  end
  
  #def test
  #  mail to: "woron@nights.su", subject: "Account activation"
  #end
  
  def password_recover(recover)
    I18n.locale = "ru"
    @recover = recover
    mail to: @recover.user.email, subject: "Восстановление учетной записи"
  end
  #handle_asynchronously :password_recover
  
  def resumes_list(email, sender, list)
    I18n.locale = "ru"
    @resumes = list
    @sender = sender
    mail to: email, subject: "Список рекомендуемых резюме"
  end
  
  def vacancies_list(email, sender, list)
    I18n.locale = "ru"
    @vacancies = list
    @sender = sender
    mail to: email, subject: "Список рекомендуемых вакансий"
  end
  
end
