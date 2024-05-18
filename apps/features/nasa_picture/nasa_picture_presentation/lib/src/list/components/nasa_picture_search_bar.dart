import 'package:flutter/material.dart';

class NasaPictureSearchBar extends StatefulWidget {
  final Function(String) onChanged;
  final String? hint;
  final String? text;

  const NasaPictureSearchBar({
    Key? key,
    required this.onChanged,
    this.hint,
    this.text,
  }) : super(key: key);

  @override
  _NasaPictureSearchBarState createState() => _NasaPictureSearchBarState();
}

class _NasaPictureSearchBarState extends State<NasaPictureSearchBar> {
  final focusNode = FocusNode();
  late TextEditingController textEditingController;
  bool showClearButton = false;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  void didUpdateWidget(covariant NasaPictureSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.text != oldWidget.text && widget.text != textEditingController.text) {
      textEditingController.text = widget.text ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      onChanged: _onChanged,
      focusNode: focusNode,
      decoration: InputDecoration(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        hintText: widget.hint,
        prefixIcon: const Icon(Icons.search),
        prefixIconColor: Colors.black,
      ),
    );
  }

  void _onChanged(String text) {
    setState(() {
      showClearButton = textEditingController.text.isNotEmpty;
    });
    widget.onChanged(text);
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
}
