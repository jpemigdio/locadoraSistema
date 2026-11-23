import 'package:supabase/supabase.dart';

//MÉTODO PARA CADASTRAR VEICULO
//Future: indica que o metodo trabalha com operação assíncrona
//Map: retorna registro com seus campos e valores

Future<Map<String, dynamic>> cadastrarVeiculo(
  SupabaseClient cliente,
  String marca,
  String modelo,
  int ano,
  double valor,
  int quilometragem,
) async {
  final resposta = await cliente
      .from('veiculos')
      .insert({
        'marca': marca,
        'modelo': modelo,
        'ano': ano,
        'valor': valor,
        'quilometragem': quilometragem,
      })
      .select()
      .single(); //indica que espera receber apenas um registro

  return resposta;
}

//MÉTODO PARA LISTAR OS VEICULOS
//List retorna uma lista de registro
//dynamic os valores podem ter diferentes tipos
Future<List<Map<String, dynamic>>> listarVeiculos(
  SupabaseClient cliente,
) async {
  final resposta = await cliente
      .from('veiculos')
      .select()
      .order(
        'id',
        ascending: true,
      ); //organiza os veiculos pelo ID em ordem crescente
  return resposta;
}

//ATUALIZAR VEICULOS PELO ID

Future<Map<String, dynamic>?> atualizarVeiculo(
  SupabaseClient cliente,
  int id,
  String marca,
  String modelo,
  int ano,
  double valor,
  int quilometragem,
) async {
  final resposta = await cliente
      .from('veiculos')
      .update({
        //atualiza e informamos quais campos serao atualizados
        'marca': marca,
        'modelo': modelo,
        'ano': ano,
        'valor': valor,
        'quilometragem': quilometragem,
      })
      .eq('id', id) //somente o veiculo cujo o ID for informado pelo usuario vai ser atualizado
      .select()
      .maybeSingle(); //se encontrar o veiculo retorna atualizado, se nao retorna null
  return resposta;
}

//EXCLUIR VEICULO PELO ID
Future<Map<String, dynamic>?> excluirVeiculo(
  SupabaseClient cliente,
  int id,
) async {
  final resposta = await cliente
      .from('veiculos')
      .delete()
      .eq('id', id)
      .select()
      .maybeSingle();

  return resposta;
}
