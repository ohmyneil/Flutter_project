import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool showItinerary = true;

  // Category filter state
  String selectedCategoryUpcoming = 'All';
  String selectedCategoryCompleted = 'All';
  String selectedCategoryCancelled = 'All'; // <-- Added

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildToggleButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () => setState(() => showItinerary = true),
          icon: Icon(Icons.check),
          label: Text("Itinerary"),
          style: ElevatedButton.styleFrom(
            backgroundColor: showItinerary ? Colors.blue.shade100 : Colors.white,
            foregroundColor: Colors.black,
            side: BorderSide(color: Colors.blue),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
        SizedBox(width: 10),
        ElevatedButton.icon(
          onPressed: () => setState(() => showItinerary = false),
          icon: Icon(Icons.list),
          label: Text("List"),
          style: ElevatedButton.styleFrom(
            backgroundColor: !showItinerary ? Colors.blue.shade100 : Colors.white,
            foregroundColor: Colors.black,
            side: BorderSide(color: Colors.blue),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryFilters({required String selected, required void Function(String) onChanged}) {
    final categories = ["All", "Hotels", "Flights", "Activities"];
    final icons = [Icons.check, Icons.apartment, Icons.flight, Icons.local_activity];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: List.generate(categories.length, (i) {
          final isSelected = selected == categories[i];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              avatar: Icon(icons[i], size: 18, color: isSelected ? Colors.white : Colors.black),
              label: Text(categories[i]),
              selected: isSelected,
              onSelected: (_) => onChanged(categories[i]),
              selectedColor: Colors.blue,
              backgroundColor: Colors.grey.shade200,
              labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
              shape: StadiumBorder(),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildNoTripsCard({required String message}) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(Icons.luggage, size: 80, color: Colors.blue),
          SizedBox(height: 16),
          Text(message, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(
            "The world is waiting! Explore destinations and let your next adventure find you.",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedTripCard() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Manila", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Spacer(),
              Text("Wed, May 28", style: TextStyle(color: Colors.grey)),
            ],
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.chat, color: Colors.blue),
                SizedBox(width: 8),
                Text("Contact Agoda Customer Service")
              ],
            ),
          ),
          SizedBox(height: 8),
          Text("ID: 1615108293"),
          SizedBox(height: 8),
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                color: Colors.grey.shade300,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("mySTAY Hotel BGC West", style: TextStyle(fontWeight: FontWeight.bold)),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text("Completed", style: TextStyle(color: Colors.green.shade800, fontSize: 12)),
                        )
                      ],
                    ),
                    SizedBox(height: 4),
                    Text("Check in: Wed, May 28"),
                    Text("Check out: Fri, May 30"),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, minimumSize: Size(double.infinity, 48)),
            child: Text("Manage booking"),
          ),
          SizedBox(height: 8),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(minimumSize: Size(double.infinity, 48)),
            child: Text("Submit your review"),
          )
        ],
      ),
    );
  }

  Widget _buildPlanningSection() {
    List<Map<String, dynamic>> options = [
      {"icon": Icons.apartment, "label": "Find Places to Stay"},
      {"icon": Icons.local_activity, "label": "Find Activities"},
      {"icon": Icons.flight, "label": "Find Flights"},
      {"icon": Icons.local_taxi, "label": "Find Airport Transfers"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text("Start planning your next trip?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 12),
          itemCount: options.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 100,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (_, i) {
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: InkWell(
                onTap: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(options[i]["icon"], size: 32, color: Colors.blue),
                    SizedBox(height: 8),
                    Text(
                      options[i]["label"],
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Bookings", style: TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.blue,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: "Upcoming"),
              Tab(text: "Completed"),
              Tab(text: "Cancelled"),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            // Upcoming tab
            ListView(
              children: [
                SizedBox(height: 12),
                _buildToggleButtons(),
                SizedBox(height: 12),
                _buildCategoryFilters(
                  selected: selectedCategoryUpcoming,
                  onChanged: (val) => setState(() => selectedCategoryUpcoming = val),
                ),
                _buildNoTripsCard(message: "No upcoming trips yet"),
                _buildPlanningSection(),
              ],
            ),

            // Completed tab
            ListView(
              children: [
                SizedBox(height: 12),
                _buildCategoryFilters(
                  selected: selectedCategoryCompleted,
                  onChanged: (val) => setState(() => selectedCategoryCompleted = val),
                ),
                _buildCompletedTripCard(),
              ],
            ),

            // Cancelled tab (now mirrors Upcoming UI)
            ListView(
              children: [
                SizedBox(height: 12),
                _buildToggleButtons(),
                SizedBox(height: 12),
                _buildCategoryFilters(
                  selected: selectedCategoryCancelled,
                  onChanged: (val) => setState(() => selectedCategoryCancelled = val),
                ),
                _buildNoTripsCard(message: "No cancelled trips yet"),
                _buildPlanningSection(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
