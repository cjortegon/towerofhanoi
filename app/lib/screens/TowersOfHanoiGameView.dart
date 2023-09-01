import 'package:flutter/material.dart';
import 'package:towerofhanoi/controllers/SolutionsController.dart';
import 'package:towerofhanoi/models/Movement.dart';
import 'package:towerofhanoi/models/Tower.dart';

class TowersOfHanoiGameView extends StatefulWidget {

  final int numberOfDisks;
  final int speed;
  List <Tower> towers = [];

  TowersOfHanoiGameView({required this.numberOfDisks, required this.speed}) {
    for (int i = 0; i < 3; i++) {
      towers.add(Tower(String.fromCharCode(65 + i)));
    }
    for (int i = numberOfDisks; i > 0; i--) {
      towers[0].disks.add(i);
    }
  }

  @override
  State<TowersOfHanoiGameView> createState() => _TowersOfHanoiGameViewState();
}

class _TowersOfHanoiGameViewState extends State<TowersOfHanoiGameView> {

  List <Movement> movements = [];
  int movesCount = 0;

  @override
  void initState() {
    super.initState();
    if(widget.numberOfDisks == 3) {
      movements = [
        Movement(1, "A", "C"),
        Movement(2, "A", "B"),
        Movement(1, "C", "B"),
        Movement(3, "A", "C"),
        Movement(1, "B", "A"),
        Movement(2, "B", "C"),
        Movement(1, "A", "C"),
      ];
    } else {
      SolutionsController().getSolution(widget.numberOfDisks)
      .then((movements) {
        setState(() {
          this.movements = movements;
        });
      })
      .catchError((error) {
        print("--- Error ---");
        print(error);
        print("-------------");
      });
    }
  }

  void solveRecursive() {
    if(movements.isEmpty) {
      return;
    }
    Movement nextMove = movements.removeAt(0);
    print("Take disk ${nextMove.disk} from rod ${nextMove.source} to rod ${nextMove.target}");
    moveDisk(nextMove.source, nextMove.target);

    Future.delayed(Duration(milliseconds: widget.speed), () {
      solveRecursive();
    });
  }

  void moveDisk(String from, String to) {
    Tower? source = getTower(from);
    Tower? target = getTower(to);
    if(source == null || target == null) {
      return;
    }
    if(source.disks.isNotEmpty) {
      int disk = source.disks.removeLast();
      target.disks.add(disk);
    }
    setState(() {
      movesCount++;
    });
  }

  Tower? getTower(String name) {
    for(int i = 0; i < widget.towers.length; i++) {
      Tower tower = widget.towers[i];
      if(tower.name == name) {
        return tower;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              movements.isNotEmpty
              ? ElevatedButton(onPressed: () { solveRecursive(); }, child: const Text('Solve!'))
              : Text(widget.towers.first.disks.isNotEmpty ? "Getting the solution..." : "Finished!"),
            ]
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          Center(
            child: Text("Moves: $movesCount"),
          ),
          const Spacer(),
          towersWidget(),
          const Padding(padding: EdgeInsets.only(bottom: 50)),
        ]
      )
    );
  }

  Widget towersWidget() {
    return Row(
      children: [
        const Spacer(),
        renderTower(widget.towers[0]),
        const Spacer(),
        renderTower(widget.towers[1]),
        const Spacer(),
        renderTower(widget.towers[2]),
        const Spacer(),
      ]
    );
  }

  Widget renderTower(Tower tower) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: 10,
          height: 400,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Column(
          children: tower.disks.reversed.map((disk) => renderDisk(disk)).toList(),
        ),
      ],
    );
  }

  Widget renderDisk(int disk) {
    return Container(
      width: 20 + disk * 10,
      height: 15,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

}