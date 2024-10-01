import 'package:flutter/material.dart';

import 'package:escola/components/icon_animated.dart';

class AppSearch extends StatefulWidget {
  final Widget itens;
  final String title;
  final Function()? onTap;
  final String search;
  final Function(String)? onChangedSearch;
  final Function()? secondaryActionIcon;
  const AppSearch(
    BuildContext context, {
    super.key,
    required this.itens,
    required this.title,
    this.onTap,
    required this.search,
    this.onChangedSearch,
    this.secondaryActionIcon,
  });

  @override
  State<AppSearch> createState() => _AppSearchState();
}

class _AppSearchState extends State<AppSearch> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: TextFormField(
                controller: widget.search.isEmpty
                    ? TextEditingController(text: "")
                    : null,
                decoration: InputDecoration(
                  label: const Text("pesquisa"),
                  suffixIcon: AppIconAnimated(
                    primaryIcon: Icons.search,
                    secondaryIcon: Icons.close,
                    secondaryActionIcon: widget.secondaryActionIcon,
                    isSelected: widget.search.isEmpty,
                  ),
                ),
                onChanged: widget.onChangedSearch),
          ),
          widget.itens
        ],
      ),
    );
  }
}
