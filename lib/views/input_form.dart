import 'package:flutter/material.dart';

typedef SubmitCallback = bool Function(String text);

class InputForm extends StatefulWidget {
  const InputForm({Key? key, required this.onSubmit}) : super(key: key);

  final SubmitCallback onSubmit;

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _inputController;
  final FocusNode _inputFocus = FocusNode();
  final FocusNode _submitFocus = FocusNode();

  @override
  void initState() {
    _inputController = TextEditingController();
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
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * 0.5,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
                decoration: const InputDecoration(
                  labelText: "Input Task",
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
              child: ElevatedButton(
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
