if Spree.version.to_f < 4.0
  Deface::Override.new(
    virtual_path: 'spree/layouts/admin',
    name: 'add_insights_to_admin_side_menu',
    insert_bottom: "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
    partial: 'spree/admin/shared/insights_side_menu',
  )
else
  Deface::Override.new(
    virtual_path: 'spree/admin/shared/_main_menu',
    name: 'add_insights_to_admin_side_menu',
    insert_bottom: 'nav',
    partial: 'spree/admin/shared/insights_side_menu',
  )
end