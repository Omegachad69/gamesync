import 'package:flutter/material.dart';
import 'package:gameync/core/common/widgets/frosted_glass_box.dart';

class CustomExpansionTile extends StatefulWidget {
  final Widget title;
  final List<Widget> children;

  CustomExpansionTile({required this.title, required this.children});

  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Column(
        children: [
          FrostedGlassBox(
            theRadius2: 20,
            theWidth: double.infinity,
            theHeight: 60, // Adjust this value as needed
            theChild: ListTile(
              title: widget.title,
              trailing: Icon(
                  _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
            ),
          ),
          SizedBox(height: 5),
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: _isExpanded ? widget.children.length * 50.0 : 0,
            child: FrostedGlassBox(
              theRadius2: 20,
              theWidth: double.infinity,
              theHeight: _isExpanded ? widget.children.length * 50.0 : 0,
              theChild: SingleChildScrollView(
                child: Column(children: widget.children),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
