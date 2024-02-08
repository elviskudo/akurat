Instalasi

buat .env.local, isinya
DATA_SOURCE=main
…

yang folder .dart_tool nya pak bisa dihapus
pub get
pub add connectivity_plus
dart run build_runner build lib/ --delete-conflicting-outputs
