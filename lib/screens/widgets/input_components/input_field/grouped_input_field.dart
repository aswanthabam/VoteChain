import 'package:flutter/material.dart';
import 'package:vote/screens/widgets/input_components/input_field/input_field.dart';

class GroupedInputFieldHandler {
  late List<InputFieldHandler> inputFields;
  late GroupedInputField groupedInputField;
  final int columnCount;
  GroupedInputFieldHandler(
      {required List<InputFieldHandler> inputFields,
      required this.columnCount}) {
    inputFields = inputFields;
    groupedInputField = GroupedInputField(
      inputFields: inputFields,
      columnCount: columnCount,
    );
  }
  get widget => groupedInputField;
}

class GroupedInputField extends StatefulWidget {
  final List<InputFieldHandler> inputFields;
  final int columnCount;
  const GroupedInputField(
      {super.key, required this.inputFields, required this.columnCount});

  @override
  State<GroupedInputField> createState() => _GroupedInputFieldState();
}

class _GroupedInputFieldState extends State<GroupedInputField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 78 * widget.inputFields.length / widget.columnCount,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.columnCount,
          childAspectRatio: 3.1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: widget.inputFields.length,
        itemBuilder: (context, index) {
          return widget.inputFields[index].widget;
        },
      ),
    );
  }
}
