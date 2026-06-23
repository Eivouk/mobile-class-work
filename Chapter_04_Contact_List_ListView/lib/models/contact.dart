class Contact {
  String name;
  String image;
  String phoneNumber;

  Contact({
    required this.name,
    required this.image,
    required this.phoneNumber,
  });

  static List<Contact> getAllContacts() {
    return [
      Contact(
        name: 'James',
        image: 'assets/people-1.jpg',
        phoneNumber: '+1221155667',
      ),
      Contact(
        name: 'Mary',
        image: 'assets/people-2.jpg',
        phoneNumber: '+3351155637',
      ),
      Contact(
        name: 'John',
        image: 'assets/people-3.jpg',
        phoneNumber: '+4457788219',
      ),
      Contact(
        name: 'Jacky',
        image: 'assets/people-4.jpg',
        phoneNumber: '+9987788835',
      ),
      Contact(
        name: 'Hugo',
        image: 'assets/people-5.jpg',
        phoneNumber: '+2266998881',
      ),
    ];
  }
}
