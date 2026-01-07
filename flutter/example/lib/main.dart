import 'package:flutter/material.dart';
import 'package:pega_constellation_sdk/pega_constellation_sdk.dart';

void main() {
  runApp(const PegaConstellationApp());
}

class PegaConstellationApp extends StatelessWidget {
  const PegaConstellationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pega Constellation SDK Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ConstellationFormPage(),
    );
  }
}

class ConstellationFormPage extends StatefulWidget {
  const ConstellationFormPage({super.key});

  @override
  State<ConstellationFormPage> createState() => _ConstellationFormPageState();
}

class _ConstellationFormPageState extends State<ConstellationFormPage> {
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
      pegaUrl: 'https://example.pega.com',
      pegaVersion: '24.1.0',
      debuggable: true,
    );

    // Create SDK with mock engine for demo
    final engine = MockSdkEngine();
    _sdk = ConstellationSdk.create(config: config, engine: engine);

    // Listen to state changes
    _sdk.stateStream.listen((state) {
      setState(() {
        _state = state;
      });
    });

    // Create a case to start the form
    _sdk.createCase('MyApp-MyCase');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pega Constellation Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_state is InitialState) {
      return const Center(child: Text('Initializing...'));
    }

    if (_state is LoadingState) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_state is ErrorState) {
      final errorState = _state as ErrorState;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text('Error: ${errorState.error.message}'),
          ],
        ),
      );
    }

    if (_state is FinishedState) {
      final finishedState = _state as FinishedState;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 48),
            const SizedBox(height: 16),
            Text(finishedState.successMessage ?? 'Form submitted successfully!'),
          ],
        ),
      );
    }

    if (_state is CancelledState) {
      return const Center(child: Text('Form cancelled'));
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

    return const Center(child: Text('Unknown state'));
  }
}
