import 'package:flutter/material.dart';
import 'TowersOfHanoiGameView.dart';

class TowersSelectionView extends StatefulWidget {
  const TowersSelectionView({Key? key}) : super(key: key);

  @override
  _TowersSelectionViewState createState() => _TowersSelectionViewState();
}

//_TowersSelectionViewState class
class _TowersSelectionViewState extends State<TowersSelectionView> {
  int _towers = 2;
  int _speed = 700;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Game settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            const Text("Select 3 disks for offline solution"),
            const Padding(padding: EdgeInsets.only(top: 10)),
            DropdownButton<int>(
              value: _towers,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onChanged: (int? newValue) {
                setState(() {
                  _towers = newValue!;
                });
              },
              items: <int>[2, 3, 4, 5, 6, 7, 8, 9, 10]
                  .map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            speedSelection(),
            const Padding(padding: EdgeInsets.only(top: 20)),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TowersOfHanoiGameView(
                      numberOfDisks: _towers,
                      speed: _speed,
                    ),
                  ),
                );
              },
              child: const Text('Start the Game'),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget speedSelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Radio<int>(
          value: 1000,
          groupValue: _speed,
          onChanged: (int? value) {
            setState(() {
              _speed = value!;
            });
          },
        ),
        const Text("Slow"),
        Radio<int>(
          value: 700,
          groupValue: _speed,
          onChanged: (int? value) {
            setState(() {
              _speed = value!;
            });
          },
        ),
        const Text("Normal"),
        Radio<int>(
          value: 400,
          groupValue: _speed,
          onChanged: (int? value) {
            setState(() {
              _speed = value!;
            });
          },
        ),
        const Text("Fast"),
      ],
    );
  }
}