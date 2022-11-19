import 'package:ninety/models/user.dart';
import 'package:test/test.dart';

void main() {
  test('User class tests', () {
    final user = AppUser(
        email: "test@email.com",
        firstName: "Test Firstname",
        lastName: "Test Lastname",
        id: "1",
        role: "ADMIN",
        cctvSystem: null);

    expect(user.email, "test@email.com");
    expect(user.firstName, "Test Firstname");
    expect(user.cctvSystem, null);
  });
}
