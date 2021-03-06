module CPP-STMT-TRY
     imports C-CONFIGURATION
     imports COMPAT-SYNTAX
     imports SYMLOC-SYNTAX
     imports CPP-ABSTRACT-SYNTAX
     imports CPP-BUILTIN-SYNTAX
     imports CPP-DECL-DECLARATOR-SYNTAX
     imports CPP-DECL-INITIALIZER-SYNTAX
     imports CPP-DYNAMIC-SYNTAX
     imports CPP-ELABORATOR-SYNTAX
     imports CPP-SYNTAX
     imports CPP-TYPING-EXPR-SYNTAX
     imports CPP-TYPING-SYNTAX

     rule (.K => elaborate(Try, listToK(Catch)))
          ~> TryStmt(Try::Stmt, Catch::List)
     rule <k> elaborateDone(Try:K, Catch:K) ~> TryStmt(_, _) => .K ...</k>
          <elab>... .K => TryStmt(Try, kSeqToList(Catch)) </elab>

     rule (.K => elaborate(S)) ~> CatchAnyOp(S::Stmt)
     rule <k> elaborateDone(S:K) ~> CatchAnyOp(_) => .K ...</k>
          <elab>... .K => CatchAnyOp(S) </elab>

     context evalThrow(HOLE:Expr, _) [result(Val)]

     rule <k> Throw(E::Expr) => prepareThrow(E, E) ...</k>
          <odr-uses>... .Set => SetItem(obj(0, 0, builtinSymbol("::std::terminate()"))) ...</odr-uses>

     syntax Expr ::= prepareThrow(AExpr, K)
     context prepareThrow(_, HOLE:TypeExpr => typeof(HOLE)) [result(CPPTypeExpr)]
     context prepareThrow(_, HOLE:CPPTypeExpr)
             requires notBool isDependentInScope(HOLE) [result(CPPType)]

     rule prepareThrow(_, T:CPPArrayTypeExpr => type(pointerType(innerType(T))))
     rule prepareThrow(_, T:CPPFunctionTypeExpr => type(pointerType(T)))
     rule prepareThrow(E::Expr, T:CPPType)
          => evalThrow(figureInit(le(temp(!I:Int, utype(T)), noTrace, utype(T)), utype(T), E, CopyInit()), E)
     rule prepareThrow(E::Expr, T:CPPTypeExpr)
          => prd(prepareThrow(E, T), hasTrace(Throw(E)), type(void), T)
          requires isDependentInScope(T)
     rule prepareThrow(NoExpression(), NoExpression())
          => pre(ThrowOp(exceptionObject(type(no-type))), hasTrace(Throw(NoExpression())), type(void))

     syntax Expr ::= evalThrow(Expr, Expr)

     rule evalThrow(V:Val, E::Expr) => pre(ThrowOp(V), hasTrace(E), type(void))

     rule exceptionObject(T::CPPType) => le(exceptionObject(T), noTrace, T)

     rule <k> CatchStmt(DeclLoc(Loc::CabsLoc, D::Decl) => D, _) ...</k>
          <curr-program-loc> _ => Loc </curr-program-loc>
     context CatchStmt(NormalizedDecl(... type: HOLE:AType), _)
     context CatchStmt(DeclaratorAndSpecifiers(NormalizedDecl(... type: HOLE:AType), _), _)
     rule (.K => elaborate(BlockStmt(I, ListItem(processCatchDecl(D)) L))) ~> CatchStmt(NormalizedDecl(... type: _:CPPType) #as D::Decl, BlockStmt(I::Int, L::List))
     rule (.K => elaborate(BlockStmt(I, ListItem(processCatchDecl(D)) L))) ~> CatchStmt(DeclaratorAndSpecifiers(NormalizedDecl(... type: _:CPPType), _) #as D::Decl, BlockStmt(I::Int, L::List))

     rule <k> elaborateDone(pushBlock(I::Int) 
              ~> declareNonStaticObject(... t: T::CPPType) #as D:KItem ~> K:K) 
              ~> CatchStmt(_, _)
              => .K
          ...</k>
          <elab>... .K => CatchOp(T, {pushBlock(I) ~> D ~> K}:>Stmt) </elab>

     syntax Decl ::= processCatchDecl(Decl) [function]
     syntax Declarator ::= processCatchDecl(Declarator) [function]
     rule processCatchDecl(DeclaratorAndSpecifiers(D::Declarator, S::Set)) => DeclaratorAndSpecifiers(processCatchDecl(D), S)
     rule processCatchDecl(NormalizedDecl(... type: T::CPPType, init: NoInit() => exceptionObject(T)))
     rule processCatchDecl(NormalizedDecl(... type: T:CPPArrayType => type(pointerType(innerType(T)))))
     rule processCatchDecl(NormalizedDecl(... type: T:CPPFunctionType => type(pointerType(T))))
     rule processCatchDecl(D::Decl) => D [owise]

endmodule
