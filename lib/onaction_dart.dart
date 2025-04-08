library onaction_dart;

class OnAction {
  static OnActionListener? _onActionListener;
  static final Map<String, OnActionListener?> _onActionHashMap = {};

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