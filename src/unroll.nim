import std/[macros, genasts]

macro unroll*(forLoop: ForLoopStmt): untyped =
  var forLoop = forLoop

  forLoop[^2] = forLoop[^2][1]
  
  var genAstCall = newCall(bindSym"genAst")
  for forVar in forLoop[0 ..< ^2]:
    if forVar.kind == nnkVarTuple:
      for forVar in forVar[0 ..< ^1]:
        genAstCall.add forVar
    else:
      genAstCall.add forVar
  genAstCall.add newBlockStmt(forLoop[^1])
  
  forLoop[^1] = 
    genAst(result = ident"result", genAstCall):
      result.add genAstCall
  
  result = genAst(result = ident"result", forLoop, impl = genSym(nskMacro, "impl")):
    macro impl: untyped =
      result = newStmtList()
      forLoop
    impl()