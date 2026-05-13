class Device {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imagePath;
  final String category;
  final Map<String, String> specs;

  Device({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.category,
    required this.specs,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      imagePath: json['imagePath'],
      category: json['category'],
      specs: Map<String, String>.from(json['specs']),
    );
  }
}
