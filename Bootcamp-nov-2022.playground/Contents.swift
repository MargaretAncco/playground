import Foundation
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
extension Date {
    static func from(intArr: [Int])-> Date{
        if (intArr.count == 3){
            return Date.from(year: intArr[2], month: intArr[1], day: intArr[0]) ?? Date()
        }
        return Date()
            
    }
    static func from(year: Int, month: Int, day: Int) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        return calendar.date(from: dateComponents) ?? nil
    }
    static func yearsBetween(from startDate: Date,to endDate: Date)-> Int{
        let calendar = Calendar(identifier: .gregorian)
        let date1 = calendar.startOfDay(for: startDate)
        let date2 = calendar.startOfDay(for: endDate)
        let components = calendar.dateComponents([.day], from: date1, to: date2)
            return (components.day ?? 0 ) / 365
    }
    static func yearsOld(since: Date)-> Int{
        return yearsBetween(from: since,to: Date())
    }
}
extension String
{
    func trim() -> String
   {
    return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
   }
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
    let email: String
    var yearsOld: Int {
        let date: [Int] = self.birthDay.trim().split(separator: "/").map{
            if ($0.starts(with: "0")){
                var number: String = String($0)
                number.removeFirst()
                return Int(number)!
            }
            return Int($0) ?? 0
        }
        return Date.yearsOld(since:Date.from(intArr: date))
    }
    static func oldestPersonOf(people: [Person])-> Person?{
        var maxAge = -1
        if (!people.isEmpty){
            var oldestPerson: Person = people[0]
            for person in people{
                let personAge = person.yearsOld
                if maxAge < personAge{
                    maxAge = personAge
                    oldestPerson = person
                }
            }
            return oldestPerson
            
        }
        return nil
    }
    static func youngestPerson(people: [Person])-> Person?{
        var minAge = 100
        if (people.count != 0){
            var _youngestPerson: Person? = people.first
            for person in people {
                let personAge: Int = person.yearsOld
                if (minAge > personAge){
                    minAge = personAge
                    _youngestPerson = person
                }
            }
            return _youngestPerson
            
        }
        
        return nil
    }
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
        email = String(dataList[4])
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
var people: [Person] = []
lines.map{ people.append(Person($0))}
print("***El mas joven***")
if let youngest = Person.youngestPerson(people: people){
    print("\(youngest.nameFormatted) tiene \(youngest.yearsOld)")
    
}
print("***El mayor***")
if let oldest = Person.oldestPersonOf(people: people){
    print("\(oldest.nameFormatted) tiene \(oldest.yearsOld)")
}
print("\n***Lista de personas***")


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
class User{
    let userName: String
    let birthDay: String
    let email: String
    init(person: Person){
        userName  = String(person.email.split(separator: "@").first!)
        
        self.birthDay = person.birthDay
        self.email = person.email
    }
}
print ("\n***creando usuarios***")
let users = people.map{
    let user = User(person: $0)
    print (user.userName)
    return user
}

