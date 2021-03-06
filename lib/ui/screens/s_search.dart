import 'package:einstein/data/modules/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class UserAPI {
  static const Map<String, Account> usersList = {
    "1": Account(userName: 'Alice'),
    "2": Account(userName: 'Bob'),
    "3": Account(userName: 'John')
  };
  static Future<List<Map<String, Account?>>> getUserSuggestions(
      String query) async {
    await Future.delayed(const Duration(milliseconds: 100));
    List<Map<String, Account?>> userSuggestion = [];
    usersList.forEach((key, value) {
      final String name = value.userName.toLowerCase();
      final String queryLower = query.toLowerCase();
      if (name.contains(queryLower) & queryLower.isNotEmpty) {
        userSuggestion.add({key: value});
      }
    });
    return userSuggestion;
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: TypeAheadField<Map<String, Account?>>(
          debounceDuration: const Duration(milliseconds: 100),
          textFieldConfiguration: const TextFieldConfiguration(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
              hintText: 'Search Username',
            ),
          ),
          suggestionsCallback: UserAPI.getUserSuggestions,
          itemBuilder: (context, Map<String, Account?> suggestion) {
            String userName = suggestion.values.first!.userName;
            return ListTile(
              title: Text(userName),
            );
          },
          onSuggestionSelected: (Map<String, Account?> suggestion) {
            String userID = suggestion.keys.first;
            String userName = suggestion.values.first!.userName;

            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text('Selected user:$userID $userName'),
              ));
          },
          noItemsFoundBuilder: (context) => const SizedBox(
            height: 100,
            child: Center(
              child: Text(
                'No Users Found.',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
