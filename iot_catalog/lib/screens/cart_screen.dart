import 'package:flutter/material.dart';
import '../models/device_model.dart';
import 'home_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sepetim')),
      body: ValueListenableBuilder<List<Device>>(
        valueListenable: cartItems,
        builder: (context, items, child) {
          if (items.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Sepetiniz şu an boş.",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          double totalAmount = items.fold(0, (sum, item) => sum + item.price);

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final device = items[index];
                    return ListTile(
                      leading: Image.asset(
                        device.imagePath,
                        width: 50,
                        height: 50,
                      ),
                      title: Text(
                        device.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text("${device.price.toStringAsFixed(2)} ₺"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          final currentItems = List<Device>.from(
                            cartItems.value,
                          );
                          currentItems.removeAt(index);
                          cartItems.value = currentItems;
                        },
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Toplam Tutar",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        Text(
                          "${totalAmount.toStringAsFixed(2)} ₺",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? Colors.tealAccent
                                : Colors.blue[800],
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        backgroundColor:
                            Theme.of(context).brightness == Brightness.dark
                            ? Colors.tealAccent
                            : Colors.blueGrey[900],
                        foregroundColor:
                            Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        cartItems.value = [];
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Sipariş başarıyla oluşturuldu!"),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.pop(context);
                      },
                      child: const Text("Satın Al"),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
