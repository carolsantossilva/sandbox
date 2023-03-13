fun main() {
    val x = 30

    when(x) {
        5 -> println("x == 5")
        8 -> println("x == 5")
        10 -> {
            println("x == 10")
            println("x é uma dezena")
        }
        in 11..15 -> print("x esta entre 11 e 15")
        !in 15..20 -> println("numero nao estao no range de 16 e 20")
        else -> println("numero nao mapeado")
    }

    when {
        comecaComOi(5) -> println("5")
//        comecaComOi("oi tudo bem?") -> println("oi 1")
        comecaComOi("oi, estou bem") -> println("oi 2")
    }
}

fun comecaComOi(x: Any): Boolean {
    return when(x) {
        is String -> x.startsWith("oi")
        else -> false
    }
}