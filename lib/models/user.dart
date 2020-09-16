import '../string_util.dart';

enum LoginType { email, phone }

class User with UserUtils {
  String email;
  String phone;

  String _lastName;
  String _firstName;
  LoginType _type;

  List<User> friends = <User>[];

  User._({String firstName, String lastName, String phone, String email})
      : _firstName = firstName,
        _lastName = lastName,
        this.phone = phone,
        this.email = email {
    print("User is created!");
    _type = email != null && email != '' ? LoginType.email : LoginType.phone;
  }

  User.__(String name) {
    this._lastName = name;
  }

  factory User({String name, String phone, String email}) {
    if (name.isEmpty) throw Exception("User name is Empty");
    if (phone == null && email == null)
      throw Exception("Phone or email name is Empty");

    return User._(
        firstName: _getFirstName(name),
        lastName: _getLastName(name),
        phone: phone != null ? checkPhone(phone) : '',
        email: email != null ? checkEmail(email) : '');
  }

  static String _getLastName(String userName) => userName.split(" ")[1];
  static String _getFirstName(String userName) => userName.split(" ")[0];

  static String checkPhone(String phone) {
    String pattern = r"^(?:[+0])?[0-9]{11}";
    phone = phone.replaceAll(RegExp("[^+\\d]"), "");

    if (phone == null || phone.isEmpty) {
      throw Exception("Не вводите пустой phone");
    } else if (!RegExp(pattern).hasMatch(phone)) {
      throw Exception("Enter a valid phone number");
    }
    return phone;
  }

  static String checkEmail(String email) {
    if (!RegExp(
            r"^[a-zA-z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(email)) throw Exception("Invalid email");
    return email;
  }

  String get login {
    if (_type == LoginType.phone) return phone;
    return email;
  }

  String get name => "${"".capitalize(_firstName)} ${"".capitalize(_lastName)}";

  @override
  bool operator ==(Object object) {
    if (object == null) {
      return false;
    }

    if (object is User) {
      return _firstName == object._firstName &&
          _lastName == object._lastName &&
          (phone == object.phone || email == object.email);
    }
  }

  void addFriend(Iterable<User> newFriend) {
    friends.addAll(newFriend);
  }

  void removeFriend(User user) {
    friends.remove(User);
  }

  String get userInfo => '''
         name: $name
         email: $email
         firstName: $_firstName
         lastName: $_lastName
         friends: ${friends.toList()}
         \\n
         ''';

  @override
  String toString() {
    return """
    '
    name: $name
    email: $email
    friends: ${friends.toList()}
    """;
  }
}

mixin UserUtils {
  String capitalize(String s) => "".capitalize(s);
}
