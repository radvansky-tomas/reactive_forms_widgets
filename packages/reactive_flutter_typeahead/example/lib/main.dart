// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:reactive_flutter_typeahead/reactive_flutter_typeahead.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Reactive TypeAhead Example',
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    TypeaheadExample(),
    Center(child: Text('Just another page')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reactive TypeAhead Example')),
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'TypeAhead',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Other page',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class TypeaheadExample extends StatelessWidget {
  const TypeaheadExample({super.key});

  @override
  Widget build(BuildContext context) {
    final form = FormGroup({
      'city': FormControl<String>(value: 'Los Angeles'),
      'color': FormControl<String>(value: 'Yellow'),
    });

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            labelColor: Colors.black,
            tabs: [
              Tab(text: 'Form'),
              Tab(text: 'Another Tab'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                ReactiveForm(
                  formGroup: form,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ReactiveTypeAhead<String, String>(
                          formControlName: 'city',
                          stringify: (value) => value,
                          suggestionsCallback: (pattern) async {
                            // Simulated API call
                            await Future.delayed(
                                const Duration(milliseconds: 500));
                            final cities = [
                              'New York',
                              'Los Angeles',
                              'Chicago',
                              'Houston',
                              'Phoenix',
                              'Philadelphia',
                              'San Antonio',
                              'San Diego',
                              'Dallas',
                              'San Jose',
                              'Austin',
                              'Jacksonville',
                              'Fort Worth',
                              'Columbus',
                              'San Francisco',
                              'Charlotte',
                              'Indianapolis',
                              'Seattle',
                              'Denver',
                              'Washington',
                              'Boston',
                              'El Paso',
                              'Detroit',
                              'Nashville',
                              'Portland',
                              'Memphis',
                              'Oklahoma City',
                              'Las Vegas',
                              'Louisville',
                              'Baltimore',
                              'Milwaukee',
                              'Albuquerque',
                              'Tucson',
                              'Fresno',
                              'Sacramento',
                              'Kansas City',
                              'Long Beach',
                              'Mesa',
                              'Atlanta',
                              'Colorado Springs',
                              'Virginia Beach',
                              'Raleigh',
                              'Omaha',
                              'Miami',
                              'Oakland',
                              'Minneapolis',
                              'Tulsa',
                              'Bakersfield',
                              'Wichita',
                              'New Orleans',
                            ];
                            return cities
                                .where((city) => city
                                    .toLowerCase()
                                    .contains(pattern.toLowerCase()))
                                .toList();
                          },
                          itemBuilder: (context, city) {
                            return ListTile(
                              title: Text(city),
                            );
                          },
                          decoration: const InputDecoration(
                            labelText: 'City',
                            helperText: 'Start typing a city name',
                          ),
                        ),
                        ReactiveTypeAhead<String, String>(
                          formControlName: 'color',
                          stringify: (value) => value,
                          suggestionsCallback: (pattern) async {
                            await Future.delayed(
                                const Duration(milliseconds: 500));
                            final colors = [
                              'Red',
                              'Green',
                              'Blue',
                              'Yellow',
                              'Orange',
                              'Purple',
                              'Pink',
                              'Brown',
                              'Black',
                              'White',
                              'Gray',
                              'Cyan',
                              'Magenta',
                              'Teal',
                              'Lime',
                            ];
                            return colors
                                .where((color) => color
                                    .toLowerCase()
                                    .contains(pattern.toLowerCase()))
                                .toList();
                          },
                          itemBuilder: (context, color) {
                            return ListTile(
                              title: Text(color),
                            );
                          },
                          decoration: const InputDecoration(
                            labelText: 'Color',
                            helperText: 'Start typing a color name',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            form.control('city').markAsEnabled();
                          },
                          child: const Text('Enable'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            form.control('city').markAsDisabled();
                          },
                          child: const Text('Disable'),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              form.control('city').value = 'New York';
                            },
                            child: const Text('Set New York')),
                        ElevatedButton(
                            onPressed: () {
                              form.control('city').value = null;
                            },
                            child: const Text('Clear value')),
                        const SizedBox(height: 16),
                        ReactiveFormConsumer(
                          builder: (context, form, child) {
                            return Text(
                                'Selected city: ${form.control('city').value ?? ''}');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const Center(
                  child: Text("It's another tab"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
