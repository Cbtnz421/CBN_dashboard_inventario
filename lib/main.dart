import 'package:flutter/material.dart';

void main() {
  runApp(const DashboardInventarioApp());
}

class DashboardInventarioApp extends StatelessWidget {
  const DashboardInventarioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  title,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class RecentOrders extends StatelessWidget {
  const RecentOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      {"id": "#2000", "client": "Cliente 3", "amount": "\$100"},
      {"id": "#2001", "client": "Cliente 4", "amount": "\$200"},
      {"id": "#2002", "client": "Cliente 5", "amount": "\$300"},
      {"id": "#2003", "client": "Cliente 6", "amount": "\$400"},
      {"id": "#2004", "client": "Cliente 7", "amount": "\$500"},
    ];

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text("#${index + 1}"),
            ),
            title: Text("Pedido ${order['id']}"),
            subtitle: Text(order['client']!),
            trailing: Text(order['amount']!),
          );
        },
      ),
    );
  }
}

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = [
      {"label": "Ventas totales", "value": "\$458,633"},
      {"label": "Promedio diario", "value": "\$20,000"},
      {"label": "Tasa de conversión", "value": "65%"},
      {"label": "Cliente nuevos", "value": "98"},
    ];

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: stats.map((stat) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(stat['label']!, style: const TextStyle(fontSize: 14)),
                  Text(stat['value']!,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard ventas"),
        backgroundColor: Colors.grey[800],
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Tarjetas principales
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 2.5,
                ),
                children: const [
                  DashboardCard(
                    title: "Clientes activos",
                    value: "1,234",
                    icon: Icons.people,
                    color: Colors.blue,
                  ),
                  DashboardCard(
                    title: "Pedidos",
                    value: "98",
                    icon: Icons.shopping_cart,
                    color: Colors.orange,
                  ),
                  DashboardCard(
                    title: "Por cobrar",
                    value: "\$45,9658",
                    icon: Icons.attach_money,
                    color: Colors.green,
                  ),
                  DashboardCard(
                    title: "Ventas del Mes",
                    value: "\$25,642",
                    icon: Icons.trending_down,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Sección de pedidos recientes
            const SectionTitle(title: "Pedidos Recientes"),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: RecentOrders(),
            ),
            const SizedBox(height: 20),
            // Sección de estadísticas
            const SectionTitle(title: "Estadísticas"),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: StatsSection(),
            ),
          ],
        ),
      ),
    );
  }
}
