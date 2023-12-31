// ignore_for_file: library_private_types_in_public_api, unnecessary_null_comparison

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
    List<int> userNumbers = [];
    TextEditingController controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Informe seus números (separados por vírgula):'),
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Ex: 5, 10, 15',
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Fecha a modal
                      startNewRound(); // Inicia um novo jogo
                    },
                    child: const Text('Novo Jogo'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Fecha a modal

                      // Obter números do usuário do campo de texto
                      List<String> inputNumbers = controller.text
                          .split(',')
                          .map((e) => e.trim())
                          .toList();

                      // Converter para inteiros
                      userNumbers = inputNumbers
                          .map((e) => int.tryParse(e) ?? 0)
                          .toList();

                      // Verificar se todos os números do usuário estão no array
                      bool isWinner = userNumbers
                          .every((number) => drawnNumbers.contains(number));

                      // Exibir mensagem de acordo com o resultado
                      if (isWinner) {
                        declareWinner();
                      } else {
                        showLosingMessage();
                      }
                    },
                    child: const Text('Verificar'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void declareWinner() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Parabéns, você é o grande VENCEDOR!',
                style: TextStyle(
                  fontSize:
                      34.0, // Ajuste o tamanho da fonte conforme necessário
                  color: Colors.green, // Altere a cor para verde
                  fontWeight:
                      FontWeight.bold, // Pode adicionar negrito se desejar
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Fecha a modal
                      startNewRound(); // Inicia um novo jogo
                    },
                    child: const Text('Novo Jogo'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Fecha a modal
                    },
                    child: const Text('Cancelar'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void showLosingMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('BARRIGADA'),
          content: const Text(
              'Parece que você comeu bola meu amigo kkkk Sem torrada pra você hoje'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
              child: const Text('OK'),
            ),
          ],
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

  String getSpecialMessage(int number) {
    switch (number) {
      case 1:
        return 'Começou o Jogo';
      case 5:
        return 'Cachorro';
      case 9:
        return 'Pingo no pé 9 é';
      case 10:
        return 'Craque de Bola';
      case 11:
        return 'Um atrás do outro';
      case 13:
        return 'Deu Azar';
      case 22:
        return 'Dois patinhos na lagoa';
      case 23:
        return 'Meio Alegre';
      case 24:
        return 'Alegria, Alegria';
      case 31:
        return 'Preparem os Fogos';
      case 33:
        return 'Idade de Cristo';
      case 38:
        return 'Justiça de Goiás';
      case 45:
        return 'Fim do Primeiro Tempo';
      case 51:
        return 'Boa Idéia';
      case 55:
        return 'Dois cachorros do Padre';
      case 66:
        return 'Um tapa atrás da orelha';
      case 69:
        return 'Um indo, o outro voltando';
      case 90:
        return 'Fim do Jogo';

      // Adicione mais casos conforme necessário
      default:
        return 'Número $number!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bingo Especial de Ano Novo!'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20.0),
          // Círculo para exibir o número sorteado
          Container(
            width: 300.0,
            height: 300.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 20, 119, 20),
            ),
            child: Center(
              child: Text(
                currentNumber != null ? currentNumber.toString() : '',
                style: const TextStyle(fontSize: 120.0, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 30.0),
          // Texto abaixo do círculo
          Text(
            currentNumber != null ? getSpecialMessage(currentNumber) : '',
            style: const TextStyle(fontSize: 28.0),
          ),
          const SizedBox(height: 30.0),
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
          const SizedBox(height: 50.0),
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
                    color: Color.fromARGB(255, 143, 24, 24),
                  ),
                  child: Center(
                    child: Text(
                      number.toString(),
                      style:
                          const TextStyle(fontSize: 30.0, color: Colors.white),
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
