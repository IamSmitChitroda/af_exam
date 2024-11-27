class Contact {
  final int? id;
  final String name;
  final String number;

  Contact({this.id, required this.name, required this.number});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'number': number,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      name: map['name'],
      number: map['number'],
    );
  }
}
