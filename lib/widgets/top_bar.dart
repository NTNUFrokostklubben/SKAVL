import 'package:flutter/material.dart';
import 'package:skavl/l10n/app_localizations.dart';



class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext foreignContext;
  final double height = 25;
  const TopBar({super.key, required this.foreignContext});

  AppLocalizations? loc() {
    return AppLocalizations.of(foreignContext);
  }

  ButtonStyle menuItemStyle() {
    return ButtonStyle(
      fixedSize: WidgetStateProperty.all(Size(200, height+5)),
      minimumSize: WidgetStateProperty.all(Size(25, height)),
    );
  }

  MenuItemButton menuItem(String text, void Function() onPressed) {
    return MenuItemButton(
      onPressed: onPressed,
       style :menuItemStyle(),
      child: MenuAcceleratorLabel('&$text'), // child
    );
  }

  SubmenuButton submenu(String text, List<Widget> children) {
    return SubmenuButton(
      style :menuItemStyle(),
      menuChildren: children,
      child: MenuAcceleratorLabel('&$text'), // Parent
    );
  }

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
                  style: MenuStyle(
                    maximumSize: WidgetStateProperty.all(Size(1000, height)),
                  ),
                  children: <Widget>[
                    SubmenuButton(
                      menuChildren: <Widget>[
                        menuItem(loc()!.g_save, (){}),
                        menuItem(loc()!.topbar_saveAs, (){}),
                        menuItem(loc()!.topbar_newProject, (){}),
                        menuItem(loc()!.topbar_openProject, (){}),
                        submenu(loc()!.topbar_openRecent, []),
                        submenu(loc()!.g_share, [
                          menuItem(loc()!.g_share, (){}),
                          ]
                        ),
                        menuItem(loc()!.topbar_newWindow, (){}),
                        menuItem(loc()!.g_quit, (){}),
                      ],
                      child:  MenuAcceleratorLabel('&${loc()!.g_file}'), // Parent
                    ),
                    SubmenuButton(
                      menuChildren: <Widget>[
                        menuItem(loc()!.g_settings, (){}),
                      ],
                      child:  MenuAcceleratorLabel('&${loc()!.g_edit}'), // Parent
                    ),
                    SubmenuButton(
                      menuChildren: <Widget>[
                       
                      ],
                      child:  MenuAcceleratorLabel('&${loc()!.g_view}'), // Parent
                    ),
                    SubmenuButton(
                      menuChildren: <Widget>[
                       menuItem(loc()!.topbar_about, (){
                         showAboutDialog(
                                context: foreignContext,
                                applicationName: 'Skavl',
                                applicationVersion: '0.1.0',
                                applicationLegalese: '© 2026 Bouvetøya AS',
                              );
                       }),
                      ],
                      child:  MenuAcceleratorLabel('&${loc()!.g_help}'), // Parent
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
