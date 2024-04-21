enum SortingItems {
  newestFirst("Newest First", "-id"),
  priceLowToHigh("Price: Low to High", "price"),
  priceHightoLow("Price: High to Low", "-price"),
  popularity("Popularity", "-views");

  const SortingItems(this.name, this.value);
  final String name;
  final String value;
}
