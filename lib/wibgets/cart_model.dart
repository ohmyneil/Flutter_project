class CartItem {
  final String from;
  final String to;
  final String airline;
  final String time;
  final String price;
  final String travelClass;
  final DateTime? departureDate;
  final DateTime? returnDate;

  CartItem({
    required this.from,
    required this.to,
    required this.airline,
    required this.time,
    required this.price,
    required this.travelClass,
    this.departureDate,
    this.returnDate,
  });

  get type => null;
}

class CartService {
  // Updated: dynamic list to store both CartItem and cruise Map data
  static final List<dynamic> _items = [];

  static List<dynamic> get items => _items;

  // Add a flight booking
  static void addItem(CartItem item) {
    _items.add(item);
  }

  // Add a cruise booking (Map)
  static void addCruiseItem(Map<String, dynamic> cruiseData) {
    _items.add(cruiseData);
  }

  // Remove any item by index
  static void removeItem(int index) {
    _items.removeAt(index);
  }

  // Clear all cart items
  static void clearCart() {
    _items.clear();
  }

  // Optional: Not implemented yet
  static void removeItemById(String to) {
    // You can implement item removal by a unique key if needed
  }
}
