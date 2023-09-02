// ignore_for_file: prefer_is_empty

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Components/components.dart';
import '../cubit/news_cubit.dart';

class BusinessScreens extends StatelessWidget {
  const BusinessScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
        builder: (context, state) {
          var list = NewsCubit.get(context).business;
          if (list.length > 0) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildArticleItems(list[index], context),
              separatorBuilder: (context, index) => dividerWidget(),
              itemCount: list.length,
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
        listener: (context, state) {});
  }
}
