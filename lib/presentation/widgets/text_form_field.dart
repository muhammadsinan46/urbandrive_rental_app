import 'package:flutter/material.dart';
class InputTextField extends StatelessWidget {
  const InputTextField({
    super.key,
    required this.passwordController,
  });

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: TextFormField(
        controller: passwordController,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            prefixIconColor:
                const Color.fromARGB(255, 191, 191, 191),
            prefixIcon: const Icon(Icons.lock),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(30)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Color.fromARGB(
                        255, 79, 107, 158)),
                borderRadius: BorderRadius.circular(30)),
            hintStyle: const TextStyle(
              color: Color.fromARGB(255, 191, 191, 191),
            ),
            hintText: "Password"),
      ),
    );
  }
}
