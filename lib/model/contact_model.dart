// import 'package:contacts_service/contacts_service.dart';

class ContactModel {
  final String? displayName; // The name of the contact
  final List<String>? phoneNumbers; // List of phone numbers

  ContactModel({
    required this.displayName,
    required this.phoneNumbers,
  });

  // factory ContactModel.fromContact(Contact contact) {
  //   return ContactModel(
  //     displayName: contact.displayName,
  //     phoneNumbers: contact.phones?.map((phone) => phone.value!).toList(),
  //   );
  // }
}
