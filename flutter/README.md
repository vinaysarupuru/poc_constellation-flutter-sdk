# Pega Constellation SDK for Flutter

A Flutter SDK for embedding Pega forms into existing Flutter applications with customizable UI.

## Overview

This SDK is a Flutter adaptation of the Pega Constellation Mobile SDK originally written in Kotlin. It provides:

- **Core SDK**: Entry point and configuration for the Constellation SDK
- **Component System**: A flexible component architecture mirroring the Kotlin implementation
- **UI Components**: Ready-to-use Flutter widgets for form fields and containers
- **UI Renderer**: Component rendering system for displaying Pega forms
- **Mock Engine**: A mock engine for testing and development
- **WebView Engine**: Configuration for the WebView-based engine

## Package Structure

The Flutter SDK mirrors the Kotlin package structure:

```
flutter/
├── lib/
│   ├── core/                          # Core SDK (mirrors core/)
│   │   ├── api/                       # API interfaces and classes
│   │   ├── components/                # Component definitions
│   │   │   ├── containers/           # Container components
│   │   │   ├── fields/               # Field components
│   │   │   └── widgets/              # Widget components
│   │   └── internal/                  # Internal implementation
│   │
│   ├── ui_components/                 # UI components (mirrors ui-components-cmp/)
│   │   └── controls/form/             # Form control widgets
│   │
│   ├── ui_renderer/                   # Component renderers (mirrors ui-renderer-cmp/)
│   │   ├── containers/                # Container renderers
│   │   ├── fields/                    # Field renderers
│   │   └── widgets/                   # Widget renderers
│   │
│   ├── engine_mock/                   # Mock engine (mirrors engine-mock/)
│   │
│   └── engine_webview/                # WebView engine (mirrors engine-webview/)
│
├── example/                           # Sample application
│
└── pubspec.yaml                       # Package dependencies
```

## Getting Started

### Installation

Add the SDK to your `pubspec.yaml`:

```yaml
dependencies:
  pega_constellation_sdk:
    path: ./flutter
```

### Basic Usage

```dart
import 'package:flutter/material.dart';
import 'package:pega_constellation_sdk/pega_constellation_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ConstellationSdk _sdk;
  ConstellationSdkState _state = const InitialState();

  @override
  void initState() {
    super.initState();
    _initSdk();
  }

  void _initSdk() {
    // Create SDK configuration
    final config = ConstellationSdkConfig(
      pegaUrl: 'https://your-pega-server.com',
      pegaVersion: '24.1.0',
    );

    // Create SDK with mock engine for demo (use WebView engine for production)
    final engine = MockSdkEngine();
    _sdk = ConstellationSdk.create(config: config, engine: engine);

    // Listen to state changes
    _sdk.stateStream.listen((state) {
      setState(() => _state = state);
    });

    // Create a case to start the form
    _sdk.createCase('YourApp-YourCase');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_state is LoadingState) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_state is ReadyState) {
      final readyState = _state as ReadyState;
      return ComponentRendererProvider(
        environmentInfo: readyState.environmentInfo,
        child: SingleChildScrollView(
          child: renderComponent(context, readyState.root),
        ),
      );
    }
    return const Center(child: Text('Initializing...'));
  }
}
```

## Supported Components

### Field Components
- TextInput
- TextArea
- Email
- URL
- Integer
- Decimal
- Currency
- Checkbox
- Dropdown
- RadioButtons
- Date
- Time
- DateTime
- Phone

### Container Components
- RootContainer
- ViewContainer
- View
- Assignment
- AssignmentCard
- FlowContainer
- DefaultForm
- Region
- OneColumn
- Group
- DataReference
- ModalViewContainer
- ListView
- FieldGroupTemplate
- SimpleTable
- SimpleTableManual
- SimpleTableSelect

### Widget Components
- ActionButtons
- AlertBanner
- Dialog
- Unsupported

## Custom Components

You can create custom components by:

1. Creating a component class extending `BaseComponent`
2. Creating a renderer implementing `ComponentRenderer`
3. Registering the component definition with the `ComponentManager`

```dart
// Custom component
class MyCustomComponent extends BaseComponent {
  MyCustomComponent(super.context);

  @override
  void applyProps(Map<String, dynamic> props) {
    // Apply your custom properties
  }
}

// Custom renderer
class MyCustomRenderer implements ComponentRenderer<MyCustomComponent> {
  @override
  Widget render(MyCustomComponent component) {
    return ListenableBuilder(
      listenable: component,
      builder: (context, _) {
        return Text('My Custom Component');
      },
    );
  }
}

// Register custom component
final customDefinition = ComponentDefinition(
  type: ComponentType('MyCustom'),
  producer: (context) => MyCustomComponent(context),
);

final config = ConstellationSdkConfig(
  pegaUrl: 'https://your-pega-server.com',
  pegaVersion: '24.1.0',
  componentManager: ComponentManager.create(
    customDefinitions: [customDefinition],
  ),
);
```

## Architecture

The SDK follows a component-based architecture:

1. **ConstellationSdk**: Main entry point that orchestrates the SDK
2. **ConstellationSdkEngine**: Interface for engines that execute Pega application logic
3. **ComponentManager**: Manages component lifecycle and updates
4. **Component**: Base interface for all UI components
5. **ComponentRenderer**: Interface for rendering components as Flutter widgets

## License

This project is licensed under the MIT License - see the LICENSE file for details.
