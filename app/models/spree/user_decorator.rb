module Spree::UserDecorator
  def self.prepended(base)
    base.has_many :spree_orders, class_name: 'Spree::Order'
  end
end

::Spree::User.prepend(Spree::UserDecorator)