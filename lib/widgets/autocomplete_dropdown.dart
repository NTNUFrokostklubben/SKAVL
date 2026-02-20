import 'package:flutter/material.dart';

class AutocompleteDropdown extends StatelessWidget {
  final List<String> options;
  final ValueChanged<String> onSelected;
  final ValueChanged<String> onCreate;

  // A custom autocomplete dropdown that allows users to search for existing options or create new ones.
  const AutocompleteDropdown({
    super.key,
    required this.options,
    required this.onSelected,
    required this.onCreate,
  });

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {

        // If the search field is empty, show all options
        if (textEditingValue.text.isEmpty) {
          return options;
        }

        // Filter options based on the search query
        return options.where(
          (option) => option.toLowerCase().contains(
            textEditingValue.text.toLowerCase(),
          ),
        );
      },
      // When an option is selected, call the onSelected callback
      onSelected: (String selection) {
        onSelected(selection);
      },

      // Custom field view to allow creating new options
      fieldViewBuilder:
          (
            BuildContext context,
            TextEditingController controller,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted,
          ) {
            // When the user submits the field (e.g., presses Enter), check if the input is a new option
            return TextFormField(
              controller: controller,
              focusNode: focusNode,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                hintText: 'Search or create anomaly type',
              ),
              onFieldSubmitted: (value) {
                // If the input value is not in the options and is not empty, create a new option
                if (!options.contains(value) && value.trim().isNotEmpty) {
                  onCreate(value.trim());
                  onSelected(value.trim());
                }
              },
            );
          },

      // Custom options view to display filtered options
      optionsViewBuilder:
          (
            BuildContext context,
            AutocompleteOnSelected<String> onSelectedInternal,
            Iterable<String> filteredOptions,
          ) {
            final filtered = filteredOptions.toList();

            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 2,
                child: SizedBox(
                  width: 600,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: filtered.map((option) {
                      return ListTile(
                        title: Text(option),
                        onTap: () {
                          onSelectedInternal(option);
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          },
    );
  }
}
