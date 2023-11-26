import std/[macros, genasts]

proc genUnrollMacro*(forLoop: NimNode, resultKind: NimNodeKind): NimNode =
  var forLoop = forLoop

  forLoop[^2] = forLoop[^2][1]
  
  var genAstCall = newCall(bindSym"genAst")
  template addVar(v: NimNode) =
    if $v != "_": genAstCall.add forVar
  for forVar in forLoop[0 ..< ^2]:
    if forVar.kind == nnkVarTuple:
      for forVar in forVar[0 ..< ^1]:
        addVar forVar
    else:
      addVar forVar
  genAstCall.add newBlockStmt(forLoop[^1])
  
  forLoop[^1] = 
    genAst(result = ident"result", genAstCall):
      result.add genAstCall
  
  result = genAst(result = ident"result", forLoop, resultKind, impl = genSym(nskMacro, "impl")):
    macro impl: untyped =
      result = newNimNode(resultKind)
      forLoop
    impl()

macro unroll*(forLoop: ForLoopStmt): untyped =
  genUnrollMacro(forLoop, nnkStmtList)

macro unrollMapArray*(forLoop: ForLoopStmt): untyped =
  genUnrollMacro(forLoop, nnkBracket)

macro unrollMapSeq*(forLoop: ForLoopStmt): untyped =
  genUnrollMacro(forLoop, nnkBracket).prefix("@")