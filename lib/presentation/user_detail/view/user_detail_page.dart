import 'package:flutter/material.dart';
import 'package:test_maimaid/domain/entities/user_data.dart';

class UserDetailPage extends StatelessWidget {
  static const routeName = 'userDetail';

  final UserData _user;

  const UserDetailPage({
    Key? key,
    required UserData user,
  })  : _user = user,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_user.firstName} ${_user.lastName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: ListTile(
                leading: Image.network(
                  _user.avatar,
                ),
                title: Text('${_user.firstName} ${_user.lastName}'),
                subtitle: Text(_user.email),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In lobortis quam velit, sit amet malesuada nisi ultrices sed. Sed pellentesque orci ac lectus sollicitudin imperdiet. Donec cursus dui non leo cursus tempus. Vivamus nunc leo, vestibulum eu lorem vitae, sagittis tristique risus. Aliquam eleifend, orci a rhoncus tempor, risus lacus egestas quam, a cursus velit mi at metus. Morbi fermentum eros eros, ac rhoncus erat fringilla vitae. Fusce sed augue sit amet ante placerat vulputate. Nullam non felis quis leo laoreet gravida. Etiam lobortis consectetur bibendum.'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
