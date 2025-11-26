import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shorten_my_link/models/link_model.dart';
import 'package:shorten_my_link/pages/home/cubit/home_cubit.dart';
import 'package:shorten_my_link/services/copy_service.dart';
import 'package:shorten_my_link/ui/theme.dart';

class LinkItem extends StatelessWidget {
  final int index;
  final AliasModel aliasModel;

  const LinkItem({super.key, required this.index, required this.aliasModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: index % 2 == 0 ? Colors.white : AppTheme.primaryColorLight,
      child: ListTile(
        title: Text(
          aliasModel.lLinks.self,
          style: const TextStyle(overflow: TextOverflow.ellipsis),
        ),
        subtitle: Text(
          aliasModel.alias,
          style: const TextStyle(
            color: AppTheme.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            context.read<HomeCubit>().deleteLink(index);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Deleted link: ${aliasModel.alias}'),
                backgroundColor: AppTheme.primaryColor,
              ),
            );
          },
          icon: Icon(Icons.delete),
        ),
        onTap: () => CopyService.copyToClipboard(
          context: context,
          text: aliasModel.lLinks.self,
        ),
      ),
    );
  }
}
