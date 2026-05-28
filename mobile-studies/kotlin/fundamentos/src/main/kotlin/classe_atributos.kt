class Carro(var cor: String, val anoFabricacao: Int, val dono: Dono) {
}

class Dono(var nome: String, var idade: Int) {

}

fun main() {
    var carol = Dono("Carol", 27)
    var carro = Carro("Branco", 2007, carol)
    println(carro.cor)

    carro.cor = "Preto"
    println(carro.cor)

    println(carro.dono.nome)
    carro.dono.nome = "Diogo"

    println(carro.dono.nome)
}