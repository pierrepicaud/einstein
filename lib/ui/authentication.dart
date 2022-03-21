class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return SafeArea(
        child: Column(
      children: <Widget>[
        Text("Welcome!"),
        const SizedBox(
          height: 20,
        ),
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                Colors.blue), //Color.fromARGB(211, 14, 71, 129)
          ),
          child: const Text("Create account"),
          onPressed: () {},
        )
      ],
    ));
  }
}

