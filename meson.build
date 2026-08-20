# openos-settings — 设置 App (独立进程, Qt6 + OPENUI)
project('openos-settings', 'cpp',
  version: 'DEV2026.1',
  default_options: ['cpp_std=c++17'])

qt6 = import('qt6')
qt6_dep = dependency('qt6', modules: ['Core', 'Gui', 'Qml', 'Quick', 'Svg'])

qt6_res = qt6.preprocess(qresources: 'qml.qrc')

executable('openos-settings',
  sources: ['main.cpp', 'iconloader.cpp', 'iconloader.h', 'iconprovider.cpp', 'iconprovider.h', qt6_res],
  dependencies: [qt6_dep],
  install: true)
