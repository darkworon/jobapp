module PricelistsHelper
  def entry_types
      I18n.t('.pricelist.entry_types').map { |key, value| [ value, key.to_s ] }
  end
end
