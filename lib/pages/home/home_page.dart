import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorten_my_link/pages/home/cubit/home_cubit.dart';
import 'package:shorten_my_link/routes.dart';
import 'package:shorten_my_link/ui/input_link.dart';
import 'package:shorten_my_link/ui/link_item.dart';
import 'package:shorten_my_link/ui/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  SizedBox get _spacer => const SizedBox(height: 8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              MyRouter.go(context, MyRouter.about);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const InputLink(),
            _spacer,
            const Text(
              'Recently Viewed',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            _spacer,
            Expanded(
              child: BlocConsumer<HomeCubit, HomeState>(
                listener: (context, state) {
                  if (state is HomeErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: AppTheme.errorColor,
                        content: Text(state.message),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is HomeLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    itemCount: state.aliasList.length,
                    itemBuilder: (_, index) => LinkItem(
                      index: index,
                      aliasModel: state.aliasList[index],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
