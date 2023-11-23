import 'package:flutter/material.dart';
import 'dart:math';

class BingoScreen extends StatefulWidget {
  @override
  _BingoScreenState createState() => _BingoScreenState();
}

class _BingoScreenState extends State<BingoScreen> {
  List<int> drawnNumbers = [];
  late int currentNumber = 0;
  Random random = Random();

  void generateNewNumber() {
    // Lógica para gerar um novo número de 1 a 90
    if (drawnNumbers.length < 90) {
      List<int> availableNumbers = List<int>.generate(90, (index) => index + 1)
          .where((number) => !drawnNumbers.contains(number))
          .toList();

      int randomIndex = random.nextInt(availableNumbers.length);
      currentNumber = availableNumbers[randomIndex];

      setState(() {
        drawnNumbers.add(currentNumber);
      });
    } else {
      // Todos os números foram sorteados
      // Você pode adicionar lógica adicional ou uma mensagem ao usuário aqui
    }
  }

  void declareBingo() {
    // Todos os números foram sorteados, o jogador ganhou!
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Temos um vencedor!'),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Fecha a modal
                      startNewRound(); // Inicia um novo jogo
                    },
                    child: Text('Novo Jogo'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Fecha a modal
                    },
                    child: Text('Cancelar'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void startNewRound() {
    setState(() {
      drawnNumbers.clear();
      currentNumber = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bingo de 90 Bolas'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20.0),
          // Círculo para exibir o número sorteado
          Container(
            width: 200.0,
            height: 200.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            child: Center(
              child: Text(
                currentNumber != null ? currentNumber.toString() : '',
                style: const TextStyle(fontSize: 48.0, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          // Texto abaixo do círculo
          Text(
            'Número Sorteado: ${currentNumber != null ? currentNumber.toString() : ''}',
            style: const TextStyle(fontSize: 18.0),
          ),
          const SizedBox(height: 20.0),
          // Botões e Lista de Números Sorteados
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: generateNewNumber,
                child: const Text('Novo Número'),
              ),
              ElevatedButton(
                onPressed: declareBingo,
                child: const Text('BINGO'),
              ),
              ElevatedButton(
                onPressed: startNewRound,
                child: const Text('Nova Rodada'),
              ),
            ],
          ),
          const SizedBox(height: 180.0),
          // Lista de Números Sorteados
          Wrap(
            alignment: WrapAlignment.center,
            children: drawnNumbers.map((number) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: Center(
                    child: Text(
                      number.toString(),
                      style:
                          const TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
