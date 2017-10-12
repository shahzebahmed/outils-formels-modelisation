import TaskManagerLib

let taskManager = createTaskManager()

// Show here an example of sequence that leads to the described problem.
// For instance:
let create = taskManager.transitions.filter{$0.name == "create"}[0]
let spawn = taskManager.transitions.filter{$0.name == "spawn"}[0]
let exec = taskManager.transitions.filter{$0.name == "exec"}[0]
let success = taskManager.transitions.filter{$0.name == "success"}[0]
let fail = taskManager.transitions.filter{$0.name == "fail"}[0]
let taskPool = taskManager.places.filter{$0.name == "taskPool"}[0]
let processPool = taskManager.places.filter{$0.name == "processPool"}[0]
let inProgress = taskManager.places.filter{$0.name == "inProgress"}[0]
print("Le réseau de pétri de départ de l'exercice")
let m1 = create.fire(from: [taskPool:0, processPool:0, inProgress:0])
print(m1!)
let m2 = create.fire(from: m1!)
print(m2!)
let m3 = spawn.fire(from: m2!)
print(m3!)
let m4 = spawn.fire(from: m3!)
print(m4!)
let m5 = spawn.fire(from: m4!)
print(m5!)
print("on peut remarquer qu'il y a 3 processus pour 2 tâches")
let m6 = exec.fire(from: m5!)
print(m6!)
let m7 = exec.fire(from: m6!)
print(m7!)
let m8 = exec.fire(from: m7!)
print(m8!)
let m9 = success.fire(from: m8!)
print(m9!)
let m10 = success.fire(from: m9!)
print(m10!)
print("Il y a un problème car il y a un jeton bloqué dans inProgress")
print("")

let correctTaskManager = createCorrectTaskManager()

// Show here that you corrected the problem.
// For instance:
let createNew = correctTaskManager.transitions.filter{$0.name == "create"}[0]
let spawnNew = correctTaskManager.transitions.filter{$0.name == "spawn"}[0]
let execNew = correctTaskManager.transitions.filter{$0.name == "exec"}[0]
let successNew = correctTaskManager.transitions.filter{$0.name == "success"}[0]
let failNew = correctTaskManager.transitions.filter{$0.name == "fail"}[0]
let taskPoolNew = correctTaskManager.places.filter{$0.name == "taskPool"}[0]
let processPoolNew = correctTaskManager.places.filter{$0.name == "processPool"}[0]
let inProgressNew = correctTaskManager.places.filter{$0.name == "inProgress"}[0]
let manage = correctTaskManager.places.filter{$0.name == "manage"}[0]
print("Une des solution ci-dessous au problème de base")
let s1 = createNew.fire(from: [taskPoolNew: 0, processPoolNew: 0, inProgressNew: 0, manage: 0])
print(s1!)
let s2 = createNew.fire(from: s1!)
print(s2!)
let s3 = spawnNew.fire(from: s2!)
print(s3!)
let s4 = spawnNew.fire(from: s3!)
print(s4!)
let s5 = spawnNew.fire(from: s4!)
print(s5!)
let s6 = execNew.fire(from: s5!)
print(s6!)
let s7 = execNew.fire(from: s6!)
print(s7!)
let s8 = execNew.fire(from: s7!)
print(s8!)
let s9 = successNew.fire(from: s8!)
print(s9!)
let s10 = successNew.fire(from: s9!)
print(s10!)
print("La nouvelle place complémentaire spécifie un processus pour une tâche")
print("Donc les 2 tâches sont exécutées avec deux processus spécifiques et au final il reste un jeton dans inProgress et un dans manage")
let s11 = failNew.fire(from: s10!)
print(s11!)
print("Le jeton dans la place complémentaire permet d'exécuter le fail et détruire le jeton dans inProgress")
