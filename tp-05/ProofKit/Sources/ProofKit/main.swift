import ProofKitLib

let a: Formula = "a"
let b: Formula = "b"
let c: Formula = "c"

//let f = a&&b

print("Exercice 1 du point 2 de la séance d'exo 9")
let ex1 = !(a && (b || c))
print("ex1:")
print("formula: \(ex1)")
print("nnf    : \(ex1.nnf)")
print("dnf    : \(ex1.dnf)")
print("cnf    : \(ex1.cnf)")
print(" ")

print("Exercice 2 du point 2 de la séance d'exo 9")
let ex2 = (a => b) || !(a && c)
print("ex2:")
print("formula: \(ex2)")
print("nnf    : \(ex2.nnf)")
print("dnf    : \(ex2.dnf)")
print("cnf    : \(ex2.cnf)")
print(" ")


/*let f = (a=>b) || !(a && c)
print("formula: \(f)")
print("nnf    : \(f.nnf)")
print("dnf    : \(f.dnf)")
print("cnf    : \(f.cnf)")
*/

/*let booleanEvaluation = f.eval { (proposition) -> Bool in
    switch proposition {
        case "p": return true
        case "q": return false
        default : return false
    }
}
print(booleanEvaluation)

enum Fruit: BooleanAlgebra {

    case apple, orange

    static prefix func !(operand: Fruit) -> Fruit {
        switch operand {
        case .apple : return .orange
        case .orange: return .apple
        }
    }

    static func ||(lhs: Fruit, rhs: @autoclosure () throws -> Fruit) rethrows -> Fruit {
        switch (lhs, try rhs()) {
        case (.orange, .orange): return .orange
        case (_ , _)           : return .apple
        }
    }

    static func &&(lhs: Fruit, rhs: @autoclosure () throws -> Fruit) rethrows -> Fruit {
        switch (lhs, try rhs()) {
        case (.apple , .apple): return .apple
        case (_, _)           : return .orange
        }
    }

}

let fruityEvaluation = f.eval { (proposition) -> Fruit in
    switch proposition {
        case "p": return .apple
        case "q": return .orange
        default : return .orange
    }
}
print(fruityEvaluation)
*/
