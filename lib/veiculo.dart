class Veiculo {
  int? _id; // o ? permite que o atributo seja nulo
  String _marca = "";
  String _modelo = "";
  int _ano = 0;
  double _valor = 0;
  int _quilometragem = 0;

  //CONSTRUTOR
  Veiculo({
    this._id, //permite receber o ID diretamente, mas sem obrigatoriedade
    //required exige os demais dados, indica que os parametros sao nomeados
    required String marca,
    required String modelo,
    required int ano,
    required double valor,
    required int quilometragem,
  }) {
    this.marca = marca;
    this.modelo = modelo;
    this.ano = ano;
    this.valor = valor;
    this.quilometragem = quilometragem;
  }

  //GETTERS
  int? get id => _id;
  String get marca => _marca;
  String get modelo => _modelo;
  int get ano => _ano;
  double get valor => _valor;
  int get quilometragem => _quilometragem;

  //SETTERS
  set id(int novoId) {
    _id = novoId;
  }

  set marca(String novaMarca) {
    if (novaMarca.trim().isEmpty) {
      throw ArgumentError("Digite uma marca válida");
    }
    _marca = novaMarca.trim();
  }

  set modelo(String novoModelo) {
    if (novoModelo.trim().isEmpty) {
      throw ArgumentError("Digite um modelo válido");
    }
    _modelo = novoModelo.trim();
  }

  set ano(int novoAno) {
    if (novoAno < 1900 || novoAno > DateTime.now().year) {
      throw ArgumentError("Informe um ano maior que zero");
    }
    _ano = novoAno;
  }

  set valor(double novoValor) {
    if (novoValor <= 0) {
      throw ArgumentError("Informe um valor válido");
    }
    _valor = novoValor;
  }

  set quilometragem(int novaQuilometragem) {
    if (novaQuilometragem < 0) {
      throw ArgumentError("A quilometragem deve ser positiva");
    }
    _quilometragem = novaQuilometragem;
  }
}
