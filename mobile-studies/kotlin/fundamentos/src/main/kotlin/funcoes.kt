fun main() {
    println("Hello World")
    var nome = returnName()
    println(nome)
    dizOi("Carol", 27)

    dizOi(idade = 25, nome = "Diogo")

    dizOi(idade = 18)
}

fun returnName(): String {
    return "Carol"
}

fun dizOi(nome: String = "pessoa", idade: Int) {
    println("Oi $nome - idade $idade")
}