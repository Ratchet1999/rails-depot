class OrderMailer < ApplicationMailer
  default from: 'Sam Ruby <depot@example.com>'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.received.subject
  #
  def received(order)
    @order = order
    order.line_items.each do |line_item|
      images = line_item.product.images.to_a
      attachments.inline["#{line_item.id}_first.jpg"] = images.shift.download
      images.each do |image|
        attachments["#{line_item.id}_#{image.id}.jpg"] = image.download
      end
    end
    
    I18n.with_locale(LANGUAGES.to_h[order.user.language.capitalize]) do
      mail to: order.email, subject: 'Pragmatic Store Order Confirmation'
    end
  end

  def send_orders_summary
    @user = params[:user]
    @orders = @user.orders

    if @orders.present?
      I18n.with_locale(LANGUAGES.to_h[@user.language.capitalize]) do
        mail to: @user.email, subject: t('.subject')
      end 
    end
  end

  def shipped
    @order = order
    mail to: order.email, subject: 'Pragmatic Store Order Shipped'
  end
end
