import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: Colors.purple.shade200,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

          
            // 1. STACK
          
            Stack(
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  color: Colors.purple.shade100,
                ),
                const Positioned(
                  top: 50,
                  left: 20,
                  child: Text(
                    "Welcome Back 👋",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

          
            // 2. ROW (Info Cards)
          
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _infoCard("Users", "120", Colors.blue),
                _infoCard("Orders", "80", Colors.green),
              ],
            ),

            const SizedBox(height: 20),

          
            // 3. GRIDVIEW
          
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Menu",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _gridItem(Icons.person, "Profile"),
                _gridItem(Icons.settings, "Settings"),
                _gridItem(Icons.notifications, "Notification"),
                _gridItem(Icons.logout, "Logout"),
              ],
            ),

            const SizedBox(height: 20),

          
            // 4. LISTVIEW
          
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Recent Activity",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.check_circle, color: Colors.green),
                  title: Text("Activity ${index + 1}"),
                  subtitle: const Text("Detail activity"),
                );
              },
            ),

            const SizedBox(height: 20),

          
            // 5. CONTAINER DI DALAM COLUMN
          
            Column(
              children: [
                Container(
                  width: 200,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Container 1",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 200,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Container 2",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }


  // WIDGET CARD

  Widget _infoCard(String title, String value, Color color) {
    return Container(
      width: 150,
      height: 80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }


  // WIDGET GRID ITEM

  Widget _gridItem(IconData icon, String label) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.purple),
          const SizedBox(height: 10),
          Text(label),
        ],
      ),
    );
  }
}