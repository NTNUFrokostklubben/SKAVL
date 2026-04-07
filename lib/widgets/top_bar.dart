import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:skavl/l10n/app_localizations.dart';
import 'package:skavl/main.dart';
import 'package:skavl/pages/analysis.dart';
import 'package:skavl/pages/create_new_report.dart';
import 'package:skavl/pages/settings.dart';
import 'package:skavl/services/project_file_service.dart';
import 'package:skavl/services/project_manager_service.dart';

import '../util/navigation_util.dart';

/// A custom top bar widget that implements the PreferredSizeWidget interface,
///  allowing it to be used as an AppBar in a Scaffold.
/// The TopBar widget contains a menu bar with various menu items and submenus, providing
///  easy access to different features of the application.
class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext foreignContext;
  final double height = 25;

  const TopBar({super.key, required this.foreignContext});

  AppLocalizations? loc() {
    return AppLocalizations.of(foreignContext);
  }

  /// Returns a ButtonStyle for menu items, with fixed and minimum sizes based on the height property.
  /// This style ensures that all menu items have a consistent size, improving the overall appearance of the menu.
  /// The fixedSize is set to a width of 200 and a height slightly larger than the defined height, while the minimumSize
  ///  ensures that menu items do not shrink below the specified dimensions.
  ButtonStyle menuItemStyle() {
    return ButtonStyle(
      fixedSize: WidgetStateProperty.all(Size(200, height + 5)),
      minimumSize: WidgetStateProperty.all(Size(25, height)),
    );
  }

  /// Creates a MenuItemButton with the given text and onPressed callback.
  /// The button is styled using the menuItemStyle method to ensure consistent sizing.
  /// The text is displayed with an accelerator label, allowing for keyboard shortcuts
  ///  to be easily identified by the user.
  MenuItemButton menuItem(String text, void Function() onPressed) {
    return MenuItemButton(
      onPressed: onPressed,
      style: menuItemStyle(),
      child: MenuAcceleratorLabel('&$text'), // child
    );
  }

  /// Creates a SubmenuButton with the given text and list of child widgets.
  /// The button is styled using the menuItemStyle method to ensure consistent sizing.
  /// The text is displayed with an accelerator label, allowing for keyboard shortcuts
  ///  to be easily identified by the user.
  SubmenuButton submenu(String text, List<Widget> children) {
    return SubmenuButton(
      style: menuItemStyle(),
      menuChildren: children,
      child: MenuAcceleratorLabel('&$text'), // Parent
    );
  }

  /// Opens a project from file and sets the context
  Future<void> _openProject(BuildContext context) async {

    final projectState = context.read<ProjectManagerService>();

    final loadedFile = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['skavl'],
    );
    if (loadedFile == null) return;

    final filepath = loadedFile.files.single.path;
    if (filepath == null) return;

    final project = await ProjectFileService().loadFromFile(filepath);
    projectState.setProject(project, filepath);
  }

  /// Saves current project to specified file
  Future<void> _saveAs(BuildContext context) async {
    final projectState = context.read<ProjectManagerService>();
    if (!projectState.hasProject) return;

    final savePath = await FilePicker.saveFile(
      dialogTitle: 'Save project',
      fileName: '${projectState.loadedProject?.projectName}.skavl',
      type: FileType.custom,
      allowedExtensions: ['skavl'],
    );
    if (savePath == null) return;

    final currentProject = projectState.loadedProject;
    if (currentProject == null) return;

    await ProjectFileService().saveToFile(savePath, currentProject);

    final project = await ProjectFileService().loadFromFile(savePath);
    projectState.setProject(project, savePath);
  }
  
  Future<void> _saveProject(BuildContext context) async {
    final projectState = context.read<ProjectManagerService>();
    if (!projectState.hasProject) return;
    
    final currentProject = projectState.loadedProject;
    if (currentProject == null) return;

    final projectPath = projectState.filePath;
    if (projectPath == null) return;
    
    await ProjectFileService().saveToFile(projectPath, currentProject);
  }


  /// Builds the top bar widget, which consists of a row of menu buttons (File, Edit, View, Help).
  /// Each menu button is a SubmenuButton that contains a list of menu items or submenus,
  /// allowing for easy navigation and access to various features of the application.
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
                        menuItem(loc()!.g_home, () {
                          navigateTo(context, MyHomePage(title: "title"));
                        }),
                        menuItem("Upload page", () {
                          navigateTo(context, CreateNewReportPage());
                        }),
                        menuItem("Analysis page", () {
                          navigateTo(context, Analysis());
                        }),
                        PopupMenuDivider(),
                        menuItem(loc()!.g_save, () => _saveProject(context)),
                        menuItem(loc()!.topbar_saveAs, () => _saveAs(context)),
                        menuItem(loc()!.topbar_newProject, () {}),
                        menuItem(loc()!.topbar_openProject, () => _openProject(context)),
                        submenu(loc()!.topbar_openRecent, []),
                        submenu(loc()!.g_share, [
                          menuItem(loc()!.g_share, () {}),
                        ]),
                        menuItem(loc()!.topbar_newWindow, () {}),
                        menuItem(loc()!.g_quit, () {}),
                      ],
                      child: MenuAcceleratorLabel(
                        '&${loc()!.g_file}',
                      ), // Parent
                    ),
                    SubmenuButton(
                      menuChildren: <Widget>[
                        menuItem(loc()!.g_settings, () {
                          navigateTo(context, Settings());
                        }),
                      ],
                      child: MenuAcceleratorLabel(
                        '&${loc()!.g_edit}',
                      ), // Parent
                    ),
                    SubmenuButton(
                      menuChildren: <Widget>[],
                      child: MenuAcceleratorLabel(
                        '&${loc()!.g_view}',
                      ), // Parent
                    ),
                    SubmenuButton(
                      menuChildren: <Widget>[
                        menuItem(loc()!.topbar_about, () {
                          showAboutDialog(
                            context: foreignContext,
                            applicationName: 'Skavl',
                            applicationVersion: '0.1.0',
                            applicationLegalese: '© 2026 Bouvetøya AS',
                          );
                        }),
                      ],
                      child: MenuAcceleratorLabel(
                        '&${loc()!.g_help}',
                      ), // Parent
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
