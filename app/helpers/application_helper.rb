module ApplicationHelper
  def custom_error(model,field)
    error_messages = model.errors.full_messages_for(field)
    unless error_messages.empty?
      error_messages.each do |message|
        puts "<div class='alert alert-danger'>#{message}</div>"
      end
    end
  end
end
