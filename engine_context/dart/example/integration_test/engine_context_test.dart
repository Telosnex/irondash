import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:irondash_engine_context/irondash_engine_context.dart';

import 'package:irondash_engine_context_example/main.dart';

// The engine handle is what the plugin's native code returns for the running
// FlutterEngine: the Dart side packs the protocol version into the top 16 bits
// (EngineContext._versionShift) and the native handle into the low 48 bits.
const _version = 4;
const _versionShift = 48;
const _handleMask = (1 << _versionShift) - 1;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('getEngineHandle returns a handle of the running engine', (
    tester,
  ) async {
    await tester.pumpWidget(const EngineContextExampleApp());
    await tester.pumpAndSettle();

    final handle = await EngineContext.instance.getEngineHandle();
    expect(handle >> _versionShift, _version);
    expect(handle & _handleMask, isNonZero);

    // The handle is cached: a second call returns the same value.
    expect(await EngineContext.instance.getEngineHandle(), handle);

    expect(find.textContaining('engine handle: $handle'), findsOneWidget);
  });
}
