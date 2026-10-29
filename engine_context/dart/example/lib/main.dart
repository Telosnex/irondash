import 'package:flutter/material.dart';
import 'package:irondash_engine_context/irondash_engine_context.dart';

void main() {
  runApp(const EngineContextExampleApp());
}

class EngineContextExampleApp extends StatelessWidget {
  const EngineContextExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'irondash engine context',
      home: FutureBuilder<int>(
        future: EngineContext.instance.getEngineHandle(),
        builder: (context, snapshot) => Scaffold(
          body: Center(
            child: Text(
              snapshot.hasData
                  ? 'engine handle: ${snapshot.data}'
                  : 'waiting for engine handle',
            ),
          ),
        ),
      ),
    );
  }
}
