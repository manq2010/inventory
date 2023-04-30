def update_sale_total(sale)
    sale.update(
      total_price: ItemsSale.where(sale_id: sale.id).sum('quantity*price'),
      total_units: ItemsSale.where(sale_id: sale.id).sum('quantity'),
      total_items: sale.items.distinct.count(:item_id)
    )
  end