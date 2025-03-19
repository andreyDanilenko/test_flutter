# Проект на Flutter с Drift

Это проект, использующий Flutter для мобильных приложений и Drift для работы с базой данных SQLite.

## Шаги для запуска проекта

### 1. Установить Flutter

Для начала необходимо установить Flutter на ваш компьютер. Это можно сделать, следуя официальному руководству по установке для вашей операционной системы:

- [Установка Flutter для Windows](https://flutter.dev/docs/get-started/install/windows)
- [Установка Flutter для macOS](https://flutter.dev/docs/get-started/install/macos)
- [Установка Flutter для Linux](https://flutter.dev/docs/get-started/install/linux)

После того как вы установите Flutter, откройте терминал и выполните команду для проверки правильности установки:

```bash
flutter doctor
```

### 2. Установить зависимости проекта

```bash
flutter pub get
```

### 3. Сгенерировать файлы базы данных

```bash
flutter pub run build_runner build
```

Автоматическая генерация 

```bash
flutter pub run build_runner watch
```

### 4. Открыть эмулятор Android или iOS

```bash
open -a Simulator
```
Лучший способпредварительно открыть эмулятор на ПК

### 5. Запустить проект

```bash
flutter run
```
