import 'package:flutter/material.dart';
import 'package:gameync/core/common/widgets/frosted_glass_box.dart';

class SearchField extends StatelessWidget {
  final Function(String)? onChanges;
  const SearchField({super.key, this.onChanges});

  @override
  Widget build(BuildContext context) {
    return FrostedGlassBox(
      theHeight: 70,
      theWidth: double.infinity,
      theChild: TextFormField(
        onChanged: onChanges,
        decoration: const InputDecoration(
            hintText: 'Search ',
            suffixIcon: Padding(
              padding: EdgeInsets.only(right: 30.0),
              child: Icon(Icons.search_rounded),
            )),
      ),
    );
  }
}
