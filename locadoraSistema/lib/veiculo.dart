class Veiculo {
  int? _id; // o ? permite que o atributo seja nulo
  String _marca = "";
  String _modelo = "";
  int _ano = 0;
  double _valor = 0;
  int _quilometragem = 0;

  //CONSTRUTOR
  Veiculo({
    //indica que os parametros sao nomeados
    this._id, //permite receber o ID diretamente, mas sem obrigatoriedade
    //required exige os demais dados
    required String marca,
    required String modelo,
    required int ano,
    required double valor,
    required int quilometragem,
  }) {
    this._marca = marca;
    this._modelo = modelo;
    this._ano = ano;
    this._valor = valor;
    this._quilometragem = quilometragem;
  }

  //GETTERS
  int? get id => _id;
  String get marca => _marca;
  String get modelo => _modelo;
  int get ano => _ano;
  double get valor => _valor;
  int get quilometragem => _quilometragem;

  //
}
