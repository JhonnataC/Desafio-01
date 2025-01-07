import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CustomForm extends StatefulWidget {
  final String title;
  final String? editValue;
  final Function(String) onSubmit;

  const CustomForm({
    super.key,
    required this.title,
    this.editValue,
    required this.onSubmit,
  });

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final _formKey = GlobalKey<FormState>();
  late final _nameController;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.editValue ?? '');
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(_nameController.text);

      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(
            widget.editValue == null ? 'Adicionado!' : 'Editado!',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;

    return Form(
      key: _formKey,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(widget.title, style: theme.textTheme.titleLarge),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              width: width,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width * 0.7,
                        child: TextFormField(
                          autofocus: true,                          
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: 'Digite aqui...',
                            hintStyle: theme.textTheme.labelLarge,
                            filled: true,
                            fillColor: theme.colorScheme.onSurface,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                          cursorColor: theme.colorScheme.onPrimary,
                          onFieldSubmitted: (_) => submitForm(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Escreva alguma coisa';
                            }
                            return null;
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(LucideIcons.x),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: IconButton(
                          onPressed: submitForm,
                          style: IconButton.styleFrom(
                            backgroundColor: theme.colorScheme.secondary,
                          ),
                          icon: Icon(
                            LucideIcons.arrowUp,
                            color: theme.colorScheme.onSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
