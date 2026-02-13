import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final double height = 25;

  TopBar({super.key, required this.context});

  final List<String> options = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 25,
      backgroundColor: Color(0xFFE3E0E0),
      actions: [
        DropdownMenu(
          dropdownMenuEntries: options
              .map((option) => DropdownMenuEntry(value: option, label: option))
              .toList(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size(MediaQuery.of(context).size.width, height);
}

class MyMenuBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext foreignContext;
  final double height = 25;
  const MyMenuBar({super.key, required this.foreignContext});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: MenuBar(
                  style: new MenuStyle(
                    maximumSize: WidgetStateProperty.all(Size(500, height)),
                  ),
                  children: <Widget>[
                    SubmenuButton(
                      menuChildren: <Widget>[
                        MenuItemButton(
                          onPressed: () {
                            showAboutDialog(
                              context: context,
                              applicationName: '',
                              applicationVersion: '1.0.0',
                            );
                          },
                          child: const MenuAcceleratorLabel('&About'),
                        ),
                        MenuItemButton(
                          style: new ButtonStyle(
                            fixedSize: WidgetStateProperty.all(
                              Size(50, height),
                            ),
                          ),
                          child: const MenuAcceleratorLabel('&Save'),
                        ),
                        MenuItemButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Quit!')),
                            );
                          },
                          child: const MenuAcceleratorLabel('&Quit'),
                        ),
                      ],
                      child: const MenuAcceleratorLabel('&File'),
                    ),
                    SubmenuButton(
                      menuChildren: <Widget>[
                        MenuItemButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Settings!')),
                            );
                          },
                          child: const MenuAcceleratorLabel('&Settings'),
                        ),
                      ],
                      child: const MenuAcceleratorLabel('&Edit'),
                    ),
                    SubmenuButton(
                      menuChildren: <Widget>[
                        MenuItemButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Magnify!')),
                            );
                          },
                          child: const MenuAcceleratorLabel('&Magnify'),
                        ),
                        MenuItemButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Minify!')),
                            );
                          },
                          child: const MenuAcceleratorLabel('&Minify'),
                        ),
                      ],
                      child: const MenuAcceleratorLabel('&View'),
                    ),
                    SubmenuButton(
                      menuChildren: <Widget>[
                        MenuItemButton(
                          onPressed: () {
                            showAboutDialog(
                              context: context,
                              applicationName: '',
                              applicationVersion: '1.0.0',
                            );
                          },
                          child: const MenuAcceleratorLabel('&About'),
                        ),
                      ],
                      child: const MenuAcceleratorLabel('&Help'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size(MediaQuery.of(foreignContext).size.width, height);
}
