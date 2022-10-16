import 'package:flutter/material.dart';
import 'package:genshin_db/character.dart';
import 'package:genshin_db/create_update.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Character> _listCharacter = [
    Character(
      name: 'Diluc',
      rarity: '5-Star',
      gender: 'Male',
      element: 'Pyro',
      weapon: 'Claymore',
      region: 'Mondstadt',
    ),
    Character(
      name: 'Yae',
      rarity: '5-Star',
      gender: 'Female',
      element: 'Electro',
      weapon: 'Catalyst',
      region: 'Inazuma',
    ),
  ];

  final TextStyle cardTextStyle = TextStyle(
    fontSize: 14,
    height: 1.5,
    color: Colors.black.withOpacity(0.6),
  );

  _showButtomMenuPopup(BuildContext context, int index) {
    final characterClicked = _listCharacter[index];

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              title: Text(
                characterClicked.name,
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit'),
              onTap: () async {
                Navigator.pop(context);
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateUpdate(
                      mode: FormMode.update,
                      character: characterClicked,
                    ),
                  ),
                );
                if (result is Character) {
                  setState(() {
                    _listCharacter[index] = result;
                  });
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete'),
              onTap: () async {
                Navigator.pop(context);
                await showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text('Remove ${characterClicked.name}?'),
                    content: Text(characterClicked.gender == 'Male'
                        ? 'This will permanently delete him'
                        : 'This will permanently delete her'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, 'OK');
                          setState(() {
                            _listCharacter.removeAt(index);
                          });
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Genshin CharaDB'),
      ),
      body: ListView.builder(
        itemCount: _listCharacter.length,
        itemBuilder: (BuildContext context, int index) {
          final char = _listCharacter[index];
          return Container(
            margin: const EdgeInsets.all(8),
            child: GestureDetector(
              onLongPress: () => _showButtomMenuPopup(context, index),
              child: Card(
                elevation: 5,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        char.name,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                        ),
                      ),
                      trailing: Text(
                        char.rarity,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.8),
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.black26,
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(18, 0, 0, 10),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Gender: ${char.gender}',
                                style: cardTextStyle,
                              ),
                              Text(
                                'Element: ${char.element}',
                                style: cardTextStyle,
                              ),
                              Text(
                                'Weapon: ${char.weapon}',
                                style: cardTextStyle,
                              ),
                              Text(
                                'Region: ${char.region}',
                                style: cardTextStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateUpdate(mode: FormMode.create),
            ),
          );
          if (result is Character) {
            setState(() {
              _listCharacter.add(result);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
