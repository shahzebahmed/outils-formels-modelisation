import PetriKit

public extension PTNet {

  public func coverabilityToPTMarking(with marking : CoverabilityMarking, and p : [PTPlace]) -> PTMarking{
    var mar : PTMarking = [:]

    for tem in p
    {
      let this = correctVal(to: marking[tem]!)!
      mar[tem] = this
    }
    return mar
  }

  public func ptmarkingToCoverability(with marking : PTMarking, and p : [PTPlace]) -> CoverabilityMarking{
    var tem : CoverabilityMarking = [:]
    for v in p
    {
      tem[v] = .some(marking[v]!)
      if(500 < tem[v]!)
      {
        tem[v] = .omega
      }
    }
    return tem
  }

  public func correctVal(to a: Token) -> UInt? {
    if case .some(let value) = a {
      return value
    }
    else {
      return 1000
    }
  }

  public func verify(at marking : [CoverabilityMarking], to markingToAdd : CoverabilityMarking) -> Int
    {
      var val = 0
      for j in 0...marking.count-1
      {
        if (marking[j] == markingToAdd)
        {
          val = 1
        }
        if (markingToAdd > marking[j])
        {
        val = j+2}
      }
      return val
    }

    public func Omega(from comp : CoverabilityMarking, with marking : CoverabilityMarking, and p : [PTPlace])  -> CoverabilityMarking?
    {
      var tem = marking
      for t in p
      {
        if (comp[t]! < tem[t]!)
        {
          tem[t] = .omega
        }
      }
      return tem
    }

    public func coverabilityGraph(from marking0: CoverabilityMarking) -> CoverabilityGraph? {
        // Write here the implementation of the coverability graph generation.

        // Note that CoverabilityMarking implements both `==` and `>` operators, meaning that you
        // may write `M > N` (with M and N instances of CoverabilityMarking) to check whether `M`
        // is a greater marking than `N`.

        // IMPORTANT: Your function MUST return a valid instance of CoverabilityGraph! The optional
        // print debug information you'll write in that function will NOT be taken into account to
        // evaluate your homework.

        var transitionsC = Array (transitions)
        transitionsC.sort{$0.name < $1.name}
        let placesC = Array(places)

        var markingList : [CoverabilityMarking] = [marking0]
        var graphList : [CoverabilityGraph] = []
        var this: CoverabilityMarking
        let returnedGraph = CoverabilityGraph(marking: marking0, successors: [:])
        var compt = 0

        while(compt < markingList.count)
          {

         for t in transitionsC{

           let ptMarking = coverabilityToPTMarking(with: markingList[compt], and: placesC)
           if let firedTran = t.fire(from: ptMarking)
           {

           let convMarking = ptmarkingToCoverability(with: firedTran, and: placesC)

           let newCouv = CoverabilityGraph(marking: convMarking, successors: [:])

             returnedGraph.successors[t] = newCouv
           }

           if(returnedGraph.successors[t] != nil)
           {

             this = returnedGraph.successors[t]!.marking

             let cur = verify(at: markingList, to: this)
             if (cur != 1)
             {
               if (cur > 1)
               {
                 this = Omega(from : markingList[cur-2], with : this, and : placesC)!
               }

               graphList.append(returnedGraph)

               markingList.append(this)
             }
           }
         }
         compt = compt + 1
       }
       return returnedGraph
     }
}
