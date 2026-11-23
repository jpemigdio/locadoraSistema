import 'dart:io';

import '../lib/conexao.dart';
import '../lib/veiculos.dart';

Future<void> main() async {
  final cliente = conectar();
  print("Conexão estabelecida");

  //funcao para limpar tela
  void limparTela() {
    stdout.write('\x1B[2J\x1B[H');
  }

  void exibirMenu() {
    print("\n===== CADASTRO DE VEÍCULOS =====");
    print("1 - Cadastrar veículo");
    print("2 - Listar veículos");
    print("3 - Atualizar veículo");
    print("4 - Excluir veículo");
    print("0 - Sair");
    print("================================");
    stdout.write("O que deseja fazer? ");
  }

  // Função para ler textos
  String lerTexto(String mensagem, int limite) {
    stdout.write(mensagem);

    String texto = stdin.readLineSync()?.trim() ?? '';

    if (texto.isEmpty) {
      throw FormatException("O campo não pode ficar vazio.");
    }

    if (texto.length > limite) {
      throw FormatException("O texto ultrapassou o limite de caracteres.");
    }

    return texto;
  }

  // Função para ler números inteiros
  int lerInteiro(String mensagem, int minimo, int maximo) {
    stdout.write(mensagem);

    String entrada = stdin.readLineSync()?.trim() ?? '';
    int? numero = int.tryParse(entrada);

    if (numero == null) {
      throw FormatException("Digite um número inteiro válido.");
    }

    if (numero < minimo || numero > maximo) {
      throw FormatException("Número fora do intervalo permitido.");
    }

    return numero;
  }

  // Função para ler valores
  double lerValor(String mensagem) {
    stdout.write(mensagem);

    String entrada = stdin.readLineSync()?.trim() ?? '';

    if (!RegExp(r'^\d+([,.]\d{1,2})?$').hasMatch(entrada)) {
      throw FormatException(
        "Digite um valor válido, com até duas casas decimais.",
      );
    }

    entrada = entrada.replaceAll(',', '.');

    double? valor = double.tryParse(entrada);

    if (valor == null ||
        !valor.isFinite ||
        valor <= 0 ||
        valor >= 10000000000) {
      throw FormatException(
        "Informe um valor maior que zero e menor que 10 bilhões.",
      );
    }

    return valor;
  }

  bool executando = true;

  try {
    while (executando) {
      limparTela();
      exibirMenu();

      String? opcao = stdin.readLineSync()?.trim();

      switch (opcao) {
        case '1':
          try {
            print("\n===== CADASTRAR VEÍCULO =====");

            String marca = lerTexto("Marca: ", 50);
            String modelo = lerTexto("Modelo: ", 100);

            int ano = lerInteiro("Ano: ", 1900, DateTime.now().year);

            double valor = lerValor("Valor: ");

            int quilometragem = lerInteiro("Quilometragem: ", 0, 2147483647);

            final veiculo = await cadastrarVeiculo(
              cliente,
              marca,
              modelo,
              ano,
              valor,
              quilometragem,
            );

            print("\nVeículo cadastrado!");
            print("ID: ${veiculo['id']}");
            print("Marca: ${veiculo['marca']}");
            print("Modelo: ${veiculo['modelo']}");
            print("Ano: ${veiculo['ano']}");
            print("Valor: R\$ ${(veiculo['valor'] as num).toStringAsFixed(2)}");
            print("Quilometragem: ${veiculo['quilometragem']} km");
          } catch (e) {
            print("\nErro ao cadastrar veículo: $e");
          }
          break;

        case '2':
          try {
            print("\n===== VEÍCULOS CADASTRADOS =====");

            final veiculos = await listarVeiculos(cliente);

            if (veiculos.isEmpty) {
              print("Nenhum veículo cadastrado.");
            } else {
              for (var veiculo in veiculos) {
                print("\nID: ${veiculo['id']}");
                print("Marca: ${veiculo['marca']}");
                print("Modelo: ${veiculo['modelo']}");
                print("Ano: ${veiculo['ano']}");
                print(
                  "Valor: R\$ ${(veiculo['valor'] as num).toStringAsFixed(2)}",
                );
                print("Quilometragem: ${veiculo['quilometragem']} km");
                print("--------------------------------");
              }
            }
          } catch (e) {
            print("\nErro ao listar veículos: $e");
          }
          break;

        case '3':
          try {
            print("\n===== ATUALIZAR VEÍCULO =====");

            int id = lerInteiro("ID do veículo: ", 1, 2147483647);

            String marca = lerTexto("Nova marca: ", 50);
            String modelo = lerTexto("Novo modelo: ", 100);

            int ano = lerInteiro("Novo ano: ", 1900, DateTime.now().year);

            double valor = lerValor("Novo valor: ");

            int quilometragem = lerInteiro(
              "Nova quilometragem: ",
              0,
              2147483647,
            );

            final veiculo = await atualizarVeiculo(
              cliente,
              id,
              marca,
              modelo,
              ano,
              valor,
              quilometragem,
            );

            if (veiculo == null) {
              print("\nVeículo não encontrado.");
            } else {
              print("\nVeículo atualizado!");
              print("ID: ${veiculo['id']}");
              print("Marca: ${veiculo['marca']}");
              print("Modelo: ${veiculo['modelo']}");
              print("Ano: ${veiculo['ano']}");
              print(
                "Valor: R\$ ${(veiculo['valor'] as num).toStringAsFixed(2)}",
              );
              print("Quilometragem: ${veiculo['quilometragem']} km");
            }
          } catch (e) {
            print("\nErro ao atualizar veículo: $e");
          }
          break;

        case '4':
          try {
            print("\n===== EXCLUIR VEÍCULO =====");

            int id = lerInteiro("ID do veículo: ", 1, 2147483647);

            stdout.write("Confirma a exclusão? S/N: ");
            String confirmacao = stdin.readLineSync()?.trim() ?? '';

            if (confirmacao == 'S' || confirmacao == 's') {
              final veiculo = await excluirVeiculo(cliente, id);

              if (veiculo == null) {
                print("\nVeículo não encontrado.");
              } else {
                print("\nVeículo excluído com sucesso!");
                print("ID: ${veiculo['id']}");
                print("Marca: ${veiculo['marca']}");
                print("Modelo: ${veiculo['modelo']}");
                print("Ano: ${veiculo['ano']}");
                print(
                  "Valor: R\$ ${(veiculo['valor'] as num).toStringAsFixed(2)}",
                );
                print("Quilometragem: ${veiculo['quilometragem']} km");
              }
            } else if (confirmacao == 'N' || confirmacao == 'n') {
              print("\nExclusão cancelada.");
            } else {
              print("\nConfirmação inválida. Exclusão não realizada.");
            }
          } catch (e) {
            print("\nErro ao excluir veículo: $e");
          }
          break;

        case '0':
          print("\nSistema encerrado.");
          executando = false;
          break;

        default:
          print("\nOpção inválida. Tente novamente.");
      }
      if (executando) {
        stdout.write("\nPressione ENTER para voltar ao menu...");
        stdin.readLineSync();
}
    }
  } finally {
    cliente.dispose();
  }
}
