let input = "CARLOS JOSÉ ROBLES GOMES, fecha de nacimiento: 06/08/1995, numero de documento 78451245, tiene 2 hermanos, carlos.roblesg@hotmail.com\nMIGUEL ANGEL QUISPE OTERO, fecha de nacimiento: 28/12/1995, numero de documento 79451654, no tiene hermanos, miguel.anguel@gmail.com\nKARLA ALEXANDRA FLORES ROSAS, fecha de nacimiento: 15/02/1997, numero de documento 77485812, tiene 1 hermanos, Karla.alexandra@hotmail.com\nNICOLAS QUISPE ZEBALLOS, fecha de nacimiento: 08/10/1990, numero de documento 71748552, tiene 1 hermanos, nicolas123@gmail.com\nPEDRO ANDRE PICASSO BETANCUR, fecha de nacimiento: 17/05/1994, numero de documento 74823157, tiene 2 hermanos, pedroandrepicasso@gmail.com\nFABIOLA MARIA PALACIO VEGA, fecha de nacimiento: 02/02/1992, numero de documento 76758254, no tiene hermanos, fabi@hotmail.com](mailto:fabi@hotmail.com"

let lines = input.split(separator: "\n").map{String($0) }
func capitalizeStrToArray(_ wordsStr: String)-> [String]  {
    let capitalized = wordsStr.split(separator: " ").map{
        let firstLetter = "\($0)".first
        var word = $0.lowercased()
        word.removeFirst()
        if let firstLetter=firstLetter{
            return "\(firstLetter)" + word
        }
        return word
    }
    return capitalized
}

enum Gender{
    case F
    case M
}

class Person{
    var completeName: String = ""
    var name: String = ""
    let surnameFirst: String
    let surnameSecond: String
    let birthDay: String
    var gender: Gender = Gender.F
    let siblingsCount: Int
    let dni: String
    static func useNameToKnowGender(person: Person)-> Gender{
        if person.name.last == "a" || person.shortName.last == "a"{
            return Gender.F
        }
        return Gender.M
    }
    var shortName: String.SubSequence{
        return name.split(separator: " ").first ?? " "
    }

    var nameFormatted: String{
        let surnames = "\(surnameFirst) \(surnameSecond.first!)."
        return shortName + " " + surnames
    }
    init(_ recordStr: String){
        let dataList = recordStr.split(separator: ",")
        self.completeName = String(dataList[0])
        let completeName = capitalizeStrToArray(String(dataList[0]))
        self.birthDay = String(dataList[1]).replacing("fecha de nacimiento:", with: "")
        let wordsNameCount = completeName.count
        let surnames = completeName[(wordsNameCount-2)...(wordsNameCount-1)].map{String($0)}
        self.surnameFirst = String(surnames[0])
        self.surnameSecond = String(surnames[1])
        self.dni = String(dataList[2]).replacing("numero de documento ", with: "")
        self.name = String(completeName.joined(separator: " ")).replacing(surnames.joined(separator: " "), with: "")
        var strCount = String(dataList[3])
        
        for word in ["no ","tiene "," hermanos", " "]{
            strCount = strCount.replacing(word, with: "")
        }
        if let siblingsCount =  Int(strCount){
            self.siblingsCount = siblingsCount
        }else{
            self.siblingsCount = 0
        }
        gender = Person.useNameToKnowGender(person: self)
    }
    static func peopleSeparatedByGender(people: [Person])-> (women :[Person],men:[Person]){
        let women = people.filter{ $0.gender == Gender.F}
        let men = people.filter{ $0.gender == Gender.M}
        return (women, men)
    }
    static func printPeopleList(people: [Person]){
        if !people.isEmpty{
            for person in people{
                print("-" + person.nameFormatted)
            }
        }else{
            print("no hay")
        }

    }
}

print("***Lista de personas***")
var people: [Person] = []
lines.map{ people.append(Person($0))}


var peopleByGender = Person.peopleSeparatedByGender(people: people)
print("\nLista de mujeres\n")
Person.printPeopleList(people: peopleByGender.women)
print("\nLista de hombres\n")
Person.printPeopleList(people: peopleByGender.men)


var peopleTwoSiblings = people.filter{
    $0.siblingsCount >= 2
}
print("\n***Lista de personas con 2 a más hermanos***\n")
if !peopleTwoSiblings.isEmpty{
    for person in peopleTwoSiblings{
        print("-" + person.nameFormatted + " tiene \(person.siblingsCount) hermanos")
    }
}else{
    print("no hay")
}
