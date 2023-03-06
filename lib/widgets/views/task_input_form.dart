import 'package:flutter/material.dart';

typedef SubmitCallback = bool Function(String text);

class TaskInputForm extends StatefulWidget {
  const TaskInputForm({
    Key? key,
    required this.onSubmit,
    this.placeholder = '',
    this.initialText,
  }) : super(key: key);

  final SubmitCallback onSubmit;
  final String? initialText;
  final String? placeholder;

  @override
  State<TaskInputForm> createState() => _TaskInputFormState();
}

class _TaskInputFormState extends State<TaskInputForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _inputController;
  final FocusNode _inputFocus = FocusNode();
  final FocusNode _submitFocus = FocusNode();

  @override
  void initState() {
    _inputController = TextEditingController(text: widget.initialText);
    super.initState();
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (widget.onSubmit(_inputController.text)) {
        _formKey.currentState!.reset();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
                decoration: InputDecoration(
                  labelText: widget.placeholder,
                ),
                textInputAction: TextInputAction.next,
                autofocus: true,
                focusNode: _inputFocus,
                controller: _inputController,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onFieldSubmitted: (term) {
                  _inputFocus.unfocus();
                  submit();
                }),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: FilledButton(
                focusNode: _submitFocus,
                onPressed: () {
                  submit();
                },
                child: const Text("Submit"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
