import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/search_controller.dart';
import 'package:get/get_core/get_core.dart';

class SearchTextFormFiled extends StatelessWidget {
  const SearchTextFormFiled({
    super.key,
    required this.searchCntrl,
  });

  final SearchCntrl searchCntrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: searchCntrl.searchCntrl,
        onChanged: (value) {
          searchCntrl.searchString.value = value;

          searchCntrl.searchUserGet(value);
        },
        decoration: InputDecoration(
            prefixIcon:
                IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            suffixIcon: IconButton(
                onPressed: () {
                  searchCntrl.searchCntrl.clear();
                },
                icon: const Icon(Icons.cancel)),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      ),
    );
  }
}
