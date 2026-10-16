import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isTrunO = true;
  List<String> xOrOList = ['', '', '', '', '', '', '', '', ''];
  int filledBoxes = 0;
  bool gameHasResult = false;
  int scoreO = 0;

  int scoreX = 0;

  String winnerTitle = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              clearGame();
            },
            icon: Icon(color: Colors.white, Icons.refresh),
          ),
        ],
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 16),
        title: Text('TicTacToe'),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            getScuoreBoard(),
            SizedBox(height: 20),
            getResultButten(),
            SizedBox(height: 20),

            getGameBoard(),
            getTrun(),
          ],
        ),
      ),
      backgroundColor: Colors.grey[900],
    );
  }

  void taped(int index) {
    if (gameHasResult) {
      return;
    }
    setState(() {
      if (xOrOList[index] == '') {
        xOrOList[index] = isTrunO ? 'O' : 'X';
        filledBoxes++;
      } else {
        return;
      }

      isTrunO = !isTrunO;

      checkWinner();
    });
  }

  Widget getGameBoard() {
    return Expanded(
      child: GridView.builder(
        itemCount: 9,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              taped(index);
            },
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Center(
                child: Text(
                  xOrOList[index],
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: xOrOList[index] == 'X' ? Colors.red : Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getScuoreBoard() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Player O',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$scoreO',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Player X',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$scoreX',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getTrun() {
    return Text(
      isTrunO ? 'trun O' : 'trun X',
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  void checkWinner() {
    // سطرها (Horizontal)
    if (xOrOList[0] == xOrOList[1] &&
        xOrOList[0] == xOrOList[2] &&
        xOrOList[0] != '') {
      setResult(xOrOList[0], 'winner is ${xOrOList[0]}');
      return;
    } else if (xOrOList[3] == xOrOList[4] &&
        xOrOList[3] == xOrOList[5] &&
        xOrOList[3] != '') {
      setResult(xOrOList[3], 'winner is ${xOrOList[3]}');
      return;
    } else if (xOrOList[6] == xOrOList[7] &&
        xOrOList[6] == xOrOList[8] &&
        xOrOList[6] != '') {
      setResult(xOrOList[6], 'winner is ${xOrOList[6]}');
      return;
    }
    // ستون‌ها (Vertical)
    else if (xOrOList[0] == xOrOList[3] &&
        xOrOList[0] == xOrOList[6] &&
        xOrOList[0] != '') {
      setResult(xOrOList[0], 'winner is ${xOrOList[0]}');
      return;
    } else if (xOrOList[1] == xOrOList[4] &&
        xOrOList[1] == xOrOList[7] &&
        xOrOList[1] != '') {
      setResult(xOrOList[1], 'winner is ${xOrOList[1]}');
      return;
    } else if (xOrOList[2] == xOrOList[5] &&
        xOrOList[2] == xOrOList[8] &&
        xOrOList[2] != '') {
      setResult(xOrOList[2], 'winner is ${xOrOList[2]}');
      return;
    }
    // قطرها (Diagonal)
    else if (xOrOList[0] == xOrOList[4] &&
        xOrOList[0] == xOrOList[8] &&
        xOrOList[0] != '') {
      setResult(xOrOList[0], 'winner is ${xOrOList[0]}');
      return;
    } else if (xOrOList[2] == xOrOList[4] &&
        xOrOList[2] == xOrOList[6] &&
        xOrOList[2] != '') {
      setResult(xOrOList[2], 'winner is ${xOrOList[2]}');
      return;
    }
    if (filledBoxes == 9) {
      setResult('', 'Drow');

      return;
    }
  }

  void setResult(String winner, String title) {
    setState(() {
      gameHasResult = true;
      winnerTitle = title;
      if (winner == 'x') {
        scoreX++;
      } else if (winner == 'O') {
        scoreO++;
      } else {
        scoreO++;
        scoreX++;
      }
    });
  }

  Widget getResultButten() {
    return Visibility(
      visible: gameHasResult,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: BorderSide(color: Colors.white, width: 2),
        ),
        onPressed: () {
          setState(() {
            gameHasResult = false;
            clearGame();
          });
        },
        child: Text(
          '$winnerTitle, play again!',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void clearGame() {
    setState(() {
      for (var i = 0; i < xOrOList.length; i++) {
        xOrOList[i] = '';
      }
      filledBoxes = 0;
    });
  }
}
