  class TravelData {
    static List<Map<String, dynamic>> airlineTickets = [
      {
        'title': 'Airline Tickets',
        'description': 'Book domestic and international flights with exclusive deals',
        'items': [
          {
            'airline': 'Philippine Airlines',
            'route': 'Manila to Cebu',
            'price': '₱2,499',
            'image': 'assets/philippine_airlines.png'
          },
          {
            'airline': 'Cebu Pacific',
            'route': 'Manila to Davao',
            'price': '₱2,199',
            'image': 'assets/cebu_pacific.png'
          }
        ]
      }
    ];

    static List<Map<String, dynamic>> packageTours = [
      {
        'title': 'Domestic Packages',
        'description': 'Explore the beautiful islands of the Philippines',
        'items': [
          {
            'name': 'Boracay Island Hopping',
            'duration': '3D2N',
            'price': '₱5,999',
            'image': 'assets/boracay_tour.png'
          }
        ]
      },
      {
        'title': 'International Packages',
        'description': 'Discover amazing destinations worldwide',
        'items': [
          {
            'name': 'Bangkok Cultural Tour',
            'duration': '5D4N',
            'price': '₱15,999',
            'image': 'assets/bangkok_tour.png'
          }
        ]
      }
    ];

    static List<Map<String, dynamic>> luxuryCruises = [
      {
        'title': 'Luxury Cruise Packages',
        'description': 'Sail in style with our premium cruise lines',
        'items': [
          {
            'name': 'Mediterranean Cruise',
            'duration': '7D6N',
            'price': '₱45,999',
            'image': 'assets/mediterranean_cruise.png'
          }
        ]
      }
    ];

    static List<Map<String, dynamic>> passportVisa = [
      {
        'title': 'Passport Services',
        'description': 'Fast and reliable passport processing',
        'items': [
          {
            'service': 'New Passport Application',
            'processing': '15-20 working days',
            'fee': '₱1,200',
            'image': 'assets/passport.png'
          }
        ]
      },
      {
        'title': 'Visa Services',
        'description': 'Visa processing for various countries',
        'items': [
          {
            'service': 'Japan Tourist Visa',
            'processing': '7 working days',
            'fee': '₱2,500',
            'image': 'assets/japan_visa.png'
          }
        ]
      }
    ];
  }
