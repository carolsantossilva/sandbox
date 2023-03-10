class Pessoa(var nome: String, var idade: Int) {
    override fun toString(): String {
        return "Classe: Pessoa Nome: $nome Idade: $idade"
    }
}

fun main() {
    val carol = Pessoa("Carol", 27)
    println(carol)
}