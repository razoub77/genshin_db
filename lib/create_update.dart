import 'package:flutter/material.dart';
import 'package:genshin_db/character.dart';

enum FormMode { create, update }

class CreateUpdate extends StatefulWidget {
  const CreateUpdate({super.key, required this.mode, this.character});

  final FormMode mode;
  final Character? character;

  @override
  State<CreateUpdate> createState() => _CreateUpdateState();
}

class _CreateUpdateState extends State<CreateUpdate> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rarityController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _elementController = TextEditingController();
  final TextEditingController _weaponController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();

  @override
  initState() {
    super.initState();
    if (widget.mode == FormMode.update) {
      _nameController.text = widget.character!.name;
      _rarityController.text = widget.character!.rarity;
      _genderController.text = widget.character!.gender;
      _elementController.text = widget.character!.element;
      _weaponController.text = widget.character!.weapon;
      _regionController.text = widget.character!.region;
    }
  }

  getChar() {
    return Character(
      name: _nameController.text,
      rarity: _rarityController.text,
      gender: _genderController.text,
      element: _elementController.text,
      weapon: _weaponController.text,
      region: _regionController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mode == FormMode.create
            ? 'Create Character'
            : 'Edit Character'),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _rarityController,
                    decoration: const InputDecoration(
                      labelText: 'Rarity',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _genderController,
                    decoration: const InputDecoration(
                      labelText: 'Gender',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _elementController,
                    decoration: const InputDecoration(
                      labelText: 'Element',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _weaponController,
                    decoration: const InputDecoration(
                      labelText: 'Weapon',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _regionController,
                    decoration: const InputDecoration(
                      labelText: 'Region',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, getChar());
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
