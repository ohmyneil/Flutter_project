// lib/data_packages/data.dart

final List<Map<String, dynamic>> tourPackages = [
  {
    'title': 'Bohol Countryside Tour',
    'description': 'Explore Chocolate Hills, Tarsiers, and Loboc River Cruise.',
    'price': '₱3,200',
    'image': 'assets/bohol.jpg',
    'options': {
      'chipDates': ['Tomorrow', 'July 19', 'July 20'],
      'joinIn': {'discount': 'PHP1,500 off', 'price': '₱1,320'},
      'private': {'discount': 'PHP1,500 off', 'price': '₱3,854'},
      'location': 'Bohol Countryside Tour',
      'time': '07:00 - 14:00',
      'departure': 'Departure type: Meet up',
      'note': 'Book now for tomorrow',
      'subnote': 'Free cancellation (24 hours notice)\nInstant confirmation',
    }
  },
  {
    'title': 'Palawan Island Hopping',
    'description': 'Visit hidden lagoons and pristine beaches of El Nido.',
    'price': '₱5,499',
    'image': 'assets/palawan.jpg',
    'options': {
      'chipDates': ['Tomorrow', 'July 19', 'July 21'],
      'joinIn': {'discount': 'PHP1,000 off', 'price': '₱4,200'},
      'private': {'discount': 'PHP1,000 off', 'price': '₱6,000'},
      'location': 'Palawan Island Hopping',
      'time': '08:00 - 17:00',
      'departure': 'Departure type: Hotel pick-up',
      'note': 'Book now for next day',
      'subnote': 'Instant confirmation available',
    }
  },
  {
    'title': 'Boracay Beach Getaway',
    'description': '3D2N with hotel, breakfast, and airport transfers.',
    'price': '₱6,200',
    'image': 'assets/boracay.jpg',
    'options': {
      'chipDates': ['July 18', 'July 19', 'July 21'],
      'joinIn': {'discount': 'PHP2,000 off', 'price': '₱5,000'},
      'private': {'discount': 'PHP2,000 off', 'price': '₱7,500'},
      'location': 'Boracay Beach Getaway',
      'time': 'Flexible time slots',
      'departure': 'Departure type: Meet at airport',
      'note': 'Best value for 3D2N trip',
      'subnote': 'Includes hotel, transfers, and breakfast',
    }
  },
];
