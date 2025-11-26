import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorten_my_link/pages/home/cubit/home_cubit.dart';
import 'package:shorten_my_link/ui/theme.dart';

class InputLink extends StatefulWidget {
  const InputLink({super.key});

  @override
  State<InputLink> createState() => _InputLinkState();
}

class _InputLinkState extends State<InputLink> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Enter your link here',
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: _controller.clear,
                icon: Icon(Icons.clear),
              ),
            ),
          ),
        ),
        IconButton(icon: const Icon(Icons.send), onPressed: onLinkSubmitted),
      ],
    );
  }

  void onLinkSubmitted() {
    if (_controller.text.isEmpty || !_isValidUrlRegex(_controller.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppTheme.errorColor,
          content: Text('Please enter a valid URL'),
        ),
      );
      return;
    }

    context.read<HomeCubit>().addLink(_controller.text);
    _controller.clear();
  }

  bool _isValidUrlRegex(String url) {
    String pattern =
        r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;:/~+#-])?';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(url);
  }
}
