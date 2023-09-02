import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Components/CusttomTextField.dart';
import 'package:news/Components/components.dart';
import 'package:news/cubit/news_cubit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultFormText(
                      control: searchController,
                      type: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Search Can't be Empty";
                        } else {
                          return null;
                        }
                      },
                      onTap: () {
                        print(searchController.toString());
                      },
                      onChanged: (value) {
                        value = value;
                        NewsCubit.get(context).getSearch(value);
                      },
                      onSubmit: (s) {
                        print(s);
                      },
                      label: 'Search',
                      prefix: Icons.search),
                ),
                Expanded(child: articleBuilder(list, context, isSearch: true)),
              ],
            ));
      },
    );
  }
}
