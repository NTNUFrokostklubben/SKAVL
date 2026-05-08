# skavl

Main application for SKAVL

## Running / Building

In general the app will be runnable by running.
```shell
flutter pub get
flutter gen-l10n
```

However not all functionality of the software will work without including certain submodules from other repositories.
There are scripts in this repo for fetching the latest version of each submodule implemented in this application.
These submodules should never be changed as they have pinned versions. 
If you want to change the functionality of a module you can clone the repo for the module, change the functionality, 
make a local build and place it under the services folder as if it was a script fetched module.

**Submodule dependencies**

- [skavl-tiler](https://github.com/NTNUFrokostklubben/skavl-tiler)
- [skavl-anomaly-detection-module](https://github.com/NTNUFrokostklubben/anomaly-detection-module)
- [skavl-report-generation-module](https://github.com/NTNUFrokostklubben/report-generation-module)

### Windows

To get the submodules you must run all the fetch scripts under the scripts folder.
```
scripts/fetch_tiler.ps1
scripts/fetch_anomaly_detector.ps1
scripts/fetch_report_generator.ps1
```
This will fetch a version of each module as defined in `service-versions.json` and needs to correspond with a release tag for each module.

Once these modules are fetched, they will be moved into the build folder and started alongside the application

### Linux

To get the submodule you must run the `scripts/fetch_tiler.sh1` script.
This will download latest built stable linux release for the tiler and place it under `services/tiler` along with a version tag.
This script can be re-run to download newer version if they are present.

Once this is done, the tiler process should start automatically when the flutter application starts.

Currently, the report and anomaly modules are not supported with Linux so they will have to be run separately both during development and during deployment.
Full linux support might become a feature in the future.

## Ports.json

After the first run of the application, a `ports.json` file will be created where the connection ip and port for each submodule can be defined.
The IP and Ports parameters in this file will be passed along to the respective module once its started.
In the server release of this application, the IPs and Ports will only be used to connect, not to start the modules.

## l10n
Added i10n localization to the application. Currently `main.dart` provides an example of the syntax in scaffold for the title of the application.
app_en.arb and app_nb.arb both define localization strings, any new string must be added to both, description is necessary.
To get the functions for localization run "flutter gen-l10n". 

for the localization .arb files we use the structure of "identifier_string", where identifier prefix describes the scope of the localization string. "g_" prefix is used for global/generic. Description should reflect usage of word and be generic for generic strings, such as "share something" and not "share via email". specification must be in a scope such as "topbar_share".


## License
Open-source: AGPL-3.0 (see LICENSE)
Commercial: available on inquiry (see COMMERCIAL.md)