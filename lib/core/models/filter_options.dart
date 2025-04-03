class FilterOptions {
  final double maxPrice;
  final int minAvailableSpots;
  final double maxDistance;
  final List<String> services;
  final double minRating;

  FilterOptions({
    required this.maxPrice,
    required this.minAvailableSpots,
    required this.maxDistance,
    required this.services,
    required this.minRating,
  });
}
