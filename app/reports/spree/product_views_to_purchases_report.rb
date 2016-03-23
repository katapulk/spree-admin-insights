module Spree
  class ProductViewsToPurchasesReport < Spree::Report
    HEADERS = [:product_name, :views, :purchases]

    def self.generate(options = {})
      line_items = ::SpreeReportify::ReportDb[:spree_line_items___line_items].
      join(:spree_orders___orders, id: :order_id).
      join(:spree_variants___variants, variants__id: :line_items__variant_id).
      join(:spree_products___products, products__id: :variants__product_id).
      where(orders__state: 'complete').
      select{[line_items__quantity,
      line_items__id,
      line_items__variant_id,
      sum(quantity).as(purchases),
      products__name.as(product_name),
      products__id.as(product_id)]}.
      group(:products__name).as(:line_items)


      ::SpreeReportify::ReportDb[line_items].join(:spree_page_events___page_events, page_events__target_id: :product_id).
      where(page_events__target_type: 'Spree::Product', page_events__activity: 'view').
      select{[product_name, count('*').as(views), purchases]}.group(:product_name)
    end
  end
end