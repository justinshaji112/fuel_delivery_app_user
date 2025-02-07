import 'package:flutter/material.dart';
import 'package:fuel_delivery_app_user/utils/constants/size.dart';

class AppCheckBox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onchanged;
  const AppCheckBox({super.key, required this.value, required this.onchanged});
  @override
  State<StatefulWidget> createState() {
    return _AppCheckBoxState();
  }
}

class _AppCheckBoxState extends State<AppCheckBox> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSizes.defaultIconSize,
      child: Checkbox(
        value: _value,
        onChanged: (value) {
          if (value != null) {
            setState(() {
              _value = value;
            });
            widget.onchanged(value);
          }
        },
      ),
    );
  }

  @override
  void didUpdateWidget(AppCheckBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _value = widget.value;
    }
  }
}
