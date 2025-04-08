import 'package:flutter_test/flutter_test.dart';

import 'package:onaction_dart/onaction_dart.dart';

// import 'package:test/test.dart';

class OnAction {
  static OnActionListener? _onActionListener;
  static Map<String, OnActionListener?> _onActionHashMap = {};

  static void addOnAction(String onActionType, OnActionListener? onActionWithListener) {
    _onActionListener = onActionWithListener;
    _onActionHashMap[onActionType] = _onActionListener;
  }

  static void doAction(String type, dynamic it) {
    _onActionHashMap[type]?.onAction(it);
  }
}

abstract class OnActionListener {
  void onAction(dynamic it);
}

class MockActionListener implements OnActionListener {
  dynamic capturedValue;
  bool called = false;
  @override
  void onAction(dynamic it) {
    capturedValue = it;
    called = true;
  }
}

void main() {
  group('OnAction Tests', () {
    test('addOnAction and doAction work correctly', () {
      final mockListener = MockActionListener();
      const actionType = 'testAction';
      final testData = 123;

      OnAction.addOnAction(actionType, mockListener);
      OnAction.doAction(actionType, testData);

      expect(mockListener.called, isTrue);
      expect(mockListener.capturedValue, equals(testData));
    });

    test('doAction with no listener does not throw exception', () {
      const actionType = 'nonExistentAction';
      final testData = 'some data';

      OnAction.doAction(actionType, testData);

      // Expect no exception to be thrown.
      expect(true, isTrue); // If it gets here, no exception was thrown.
    });

    test('multiple addOnActions and doActions work correctly', () {
      final mockListener1 = MockActionListener();
      final mockListener2 = MockActionListener();
      const actionType1 = 'action1';
      const actionType2 = 'action2';
      final testData1 = 'data1';
      final testData2 = 456;

      OnAction.addOnAction(actionType1, mockListener1);
      OnAction.addOnAction(actionType2, mockListener2);

      OnAction.doAction(actionType1, testData1);
      OnAction.doAction(actionType2, testData2);

      expect(mockListener1.called, isTrue);
      expect(mockListener1.capturedValue, equals(testData1));
      expect(mockListener2.called, isTrue);
      expect(mockListener2.capturedValue, equals(testData2));
    });
  });
}