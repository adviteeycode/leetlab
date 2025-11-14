import 'package:flutter/material.dart';
import 'package:leetlab/ui/widgets/glass_morphism.dart';

class CustomSearchBar extends StatefulWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final EdgeInsetsGeometry padding;
  final double opacity;

  const CustomSearchBar({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.opacity = 0.2,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  String searchQuery = '';
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: GlassMorphism(
        opacity: widget.opacity,
        child: TextField(
          controller: _controller,
          onChanged: (value) {
            setState(() {
              searchQuery = value;
            });
            widget.onChanged(value);
          },
          decoration: InputDecoration(
            hintText: widget.hintText,
            suffixIcon: searchQuery.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        searchQuery = '';
                        _controller.clear();
                        widget.onChanged('');
                      });
                    },
                  )
                : null,

            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ),
    );
  }
}
