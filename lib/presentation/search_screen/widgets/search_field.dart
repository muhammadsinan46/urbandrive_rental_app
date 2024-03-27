


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urbandrive/application/search_bloc/search_bloc.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        onChanged: (value) {
          context.read<SearchBloc>().add(SearchWordEvent(searchValue: value));
        },
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "search your car",
          hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
            prefixIcon: Icon(Icons.search),
            prefixIconColor: Colors.grey,
            suffixIcon: IconButton(onPressed: (){
              _searchController.clear();
            }, icon:Icon(Icons.close)),
            suffixIconColor: Colors.grey,
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder()),
      ),
      height: 55,
      width: MediaQuery.sizeOf(context).width - 80,
    );
  }
}
