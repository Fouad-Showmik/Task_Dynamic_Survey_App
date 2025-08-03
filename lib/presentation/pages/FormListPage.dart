//Displays a list of available forms retrieved from your FormProvider.
// When a user taps a form, it navigates to FormPage to fill it out.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survey/presentation/pages/FormPage.dart';
import 'package:survey/providers/form_provider.dart';

class FormListPage extends StatelessWidget {
  const FormListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FormProvider>();
    final forms = provider.forms;

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Available Forms',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body:
          forms.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: forms.length,
                  itemBuilder: (context, index) {
                    final form = forms[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          provider.selectForm(form);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FormPage(form: form),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              form.formName,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
    );
  }
}
