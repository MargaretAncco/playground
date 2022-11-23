
// Tipos:

// String
// Int
// Float
// Bool
// Double

// Mutable
var alumno = ""
var perro: String

print("valor de variable alumno antes: \(alumno)")

alumno = "Diego"

print("valor de variable alumno despues: \(alumno)")

// Inmutable
let isAlive: Bool = true

// Int64  -> abarcan valores positivos y negativos
// UInt64 -> abarcan valores positivos

var mascota: String? = nil
print("---->> que es:: \(mascota ?? "fido")")

if 3 < 4 {
    print("----> hola 1")
    // do something
}else {
    print("----> hola 2")
    // haz otra cosa
}

// !  -> desempaquetado forzoso (menos recomendado)

// ?? -> desempaquetado por defecto
// if let -> desempaquetado seguro
// guard let -> desempaquetado seguro

var marcaCelular: String? = "Samsung"
if let variableDesempaquetada = marcaCelular {
    print("---->> nro de caracteres:: \(variableDesempaquetada.count)")
}else {
    print("---->> soy nul")
}

var equipoFutbol: String? = "Paraguay"
if let pepito = equipoFutbol {
    print("---->> variable segura: \(pepito)")
}

// Operadores ternarios
let needUpdate = (4.0 < 3.2) ? true : false
print("---->> necesita actualizar: \(needUpdate)")

var ios: String? = "ios14"

func validarOpcional() {
    guard let iosDesempaquetado = ios else {
        print("---->> sigo nil")
        return
    }
    
    print("---->> variable no opcional:: \(iosDesempaquetado.count)")
}

validarOpcional()
