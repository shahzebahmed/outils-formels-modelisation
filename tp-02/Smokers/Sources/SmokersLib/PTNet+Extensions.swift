import PetriKit

public class MarkingGraph {

    public let marking   : PTMarking
    public var successors: [PTTransition: MarkingGraph]

    public init(marking: PTMarking, successors: [PTTransition: MarkingGraph] = [:]) {
        self.marking    = marking
        self.successors = successors
    }

}

public extension PTNet {

    public func markingGraph(from marking: PTMarking) -> MarkingGraph? {
        // Write here the implementation of the marking graph generation.

        let marqInitial = MarkingGraph(marking: marking)
        var marqListeAVisite = [MarkingGraph]()
        var listeVisite = [MarkingGraph]()

        marqListeAVisite.append(marqInitial)

        while marqListeAVisite.count != 0 {
            let c = marqListeAVisite.removeFirst()
            listeVisite.append(c)
            transitions.forEach { t in
              if let nouvMarq = t.fire(from: c.marking) {
                        if let alreadyV = listeVisite.first(where: { $0.marking == nouvMarq }) {
                            c.successors[t] = alreadyV
                        } else {
                            let spotted = MarkingGraph(marking: nouvMarq)
                            c.successors[t] = spotted
                            if (!marqListeAVisite.contains(where: { $0.marking == spotted.marking})) {
                                marqListeAVisite.append(spotted)
                            }
                    }
                }
            }
        }

        return marqInitial
    }
    //fonction pour la question 4.1
    public func sum (mark: MarkingGraph) -> Int{
      var parc = [MarkingGraph]()
      var aParcourir = [MarkingGraph]()

      aParcourir.append(mark)
      while let c = aParcourir.popLast() {
        parc.append(c)
        for(_, successor) in c.successors{
          if !parc.contains(where: {$0 === successor}) && !aParcourir.contains(where: {$0 === successor}){
              aParcourir.append(successor)
            }
          }
      }

      return parc.count
    }
    //fonction pour la question 4.2
    public func twoPlusSmokers (mark: MarkingGraph) -> Bool {
      var parc = [MarkingGraph]()
      var aParcourir = [MarkingGraph]()

      aParcourir.append(mark)
      while let c = aParcourir.popLast() {
        parc.append(c)
        var numberOfSmokers = 0;
        for (key, value) in c.marking {
            if (key.name == "s1" || key.name == "s2" || key.name == "s3"){
               numberOfSmokers += Int(value)
            }
        }
        if (numberOfSmokers > 1) {
          return true
        }
        for(_, successor) in c.successors{
          if !parc.contains(where: {$0 === successor}) && !aParcourir.contains(where: {$0 === successor}){
              aParcourir.append(successor)
            }
          }
      }
      return false
    }
    //fonction pour la question 4.3
    public func twoTimesSameIngredient (mark: MarkingGraph) -> Bool {
      var parc = [MarkingGraph]()
      var aParcourir = [MarkingGraph]()

      aParcourir.append(mark)
      while let c = aParcourir.popLast() {
        parc.append(c)
        for (key, value) in c.marking {
            if (key.name == "p" || key.name == "t" || key.name == "m"){
               if(value > 1){
                 return true
               }
            }
        }
        for(_, successor) in c.successors{
          if !parc.contains(where: {$0 === successor}) && !aParcourir.contains(where: {$0 === successor}){
              aParcourir.append(successor)
            }
          }
      }
      return false
    }

}
