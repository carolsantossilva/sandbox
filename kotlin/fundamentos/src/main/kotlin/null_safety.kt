fun main() {
    var nome = "Carol"
//    nome = null // nao pode, porque não é optional
    println(nome.length)

    var nomeOptional: String? = "Carol"
    nomeOptional = null
    println(nomeOptional?.length ?: 4) // ?: = valor default (?? swift)
//    println(nomeOptional!!.length.toShort()) // !! = force unwrap (! swift)
}