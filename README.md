[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=EL-BID_moralar-appusuario-flutter&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=EL-BID_moralar-appusuario-flutter)

# moralar_appusuario

This is the app that the end user will have installed to check their statuses and house matches on Moralar Project.

#### Moralar Project
Here are the repositories used in the project:

- Moralar App for end user - https://github.com/EL-BID/moralar-appusuario-flutter
- Morar App for Field Agent (TTS) - https://github.com/EL-BID/moralar-apptts-flutter
- Moralar Web App for Admins, Field Agents and Public managers - https://github.com/EL-BID/moralar-admin
- Web Server for All applications - https://github.com/EL-BID/moralar-api

## Getting Started

### Requirements
- [Flutter](https://docs.flutter.dev/get-started/install). Tested with Flutter 3.22.0, Dart 2.16.2
- [Moralar Widgets](https://github.com/EL-BID/moralar-widgets)
- [Mega flutter package](https://github.com/EL-BID/mega-flutter)
- [Android emulator](https://developer.android.com/studio/run/emulator)

## API
API is not configured in this repository. You must set it up in the Moralar Widgets repository.

## Setup
- If you have problems with the dart cache you can run this commands
 * dart pub cache clean
 * dart pub get

- If you have problems with dependencies you can run: "fvm flutter clean"
- Run `flutter pub get` to fetch packages.
- Moralar widgets and Mega Flutter project folders must be siblings to moralar_appusuario like this:
  - Root Folder/
    - Moralar Widgets/
    - Mega Flutter/
    - Moralar App Usuário/
- Run an android emulator (currently, iOS development is not supported, although it is possible to run on dev mode after you fix the issues inherent to running in iOS).
- run `flutter run` and it will search for the emulators to run. If you have only one it will be automatically selected.



A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Acknowledgments / Reconocimientos

**Copyright © [2025]. Inter-American Development Bank ("IDB"). Authorized Use.**  
The procedures and results obtained based on the execution of this software are those programmed by the developers and do not necessarily reflect the views of the IDB, its Board of Executive Directors or the countries it represents.

**Copyright © [2025]. Banco Interamericano de Desarrollo ("BID"). Uso Autorizado.**  
Los procedimientos y resultados obtenidos con la ejecución de este software son los programados por los desarrolladores y no reflejan necesariamente las opiniones del BID, su Directorio Ejecutivo ni los países que representa.

### Support and Usage Documentation / Documentación de Soporte y Uso

**Copyright © [2025]. Inter-American Development Bank ("IDB").** The Support and Usage Documentation is licensed under the Creative Commons License CC-BY 4.0 license. The opinions expressed in the Support and Usage Documentation are those of its authors and do not necessarily reflect the opinions of the IDB, its Board of Executive Directors, or the countries it represents.

**Copyright © [2025]. Banco Interamericano de Desarrollo (BID).** La Documentación de Soporte y Uso está licenciada bajo la licencia Creative Commons CC-BY 4.0. Las opiniones expresadas en la Documentación de Soporte y Uso son las de sus autores y no reflejan necesariamente las opiniones del BID, su Directorio Ejecutivo ni los países que representa.
