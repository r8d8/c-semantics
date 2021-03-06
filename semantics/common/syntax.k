module COMMON-SORTS
     imports INT-SYNTAX
     imports FLOAT-SYNTAX
     syntax CId
     syntax CabsLoc
     syntax Qualifier
     syntax Quals
     syntax EvalContext
     syntax CValue ::= NumValue
     syntax NumValue ::= Int
     syntax EffectiveValue ::= Int | Float
     syntax LanguageLinkage
     syntax Namespace
     syntax Scope
endmodule

module COMMON-SYNTAX
     imports COMMON-SORTS
     imports SET
     imports STRING-SYNTAX

     syntax UnnamedCId ::= unnamed(Int, String)  // Unnamed struct/union/enums.
     syntax NoName ::= "#NoName" | #NoName(Int)  // Unnamed struct/union fields.
     syntax CId ::= NoName
     syntax CId ::= Identifier(String)
     syntax CId ::= UnnamedCId

     syntax CabsLoc ::= "UnknownCabsLoc"
     syntax CabsLoc ::= CabsLoc(rel: String, abs: String, line: Int, col: Int, systemHeader: Bool)

     syntax Qualifier ::= Const()
     syntax Qualifier ::= Volatile()
     syntax Qualifier ::= Restrict()
     syntax Qualifier ::= RestrictReserved(String, CabsLoc)
     syntax Qualifier ::= Atomic()

     syntax EvalContext ::= "eval" | "noEval"

     // Const, Restrict, Volatile, Atomic
     syntax Quals ::= quals(Set)

     syntax Quals ::= "noQuals" [function]
     syntax Bool ::= Qualifier "inQuals" Quals [function]
     syntax Quals ::= toQuals(Set) [function]
     syntax Quals ::= Quals "+Quals" Quals [function]
     syntax Quals ::= Quals "+Qual" Qualifier [function]
     syntax Quals ::= Quals "-Qual" Qualifier [function]
     syntax Bool ::= Quals "<=Quals" Quals [function]

     syntax Namespace ::= GlobalNamespace()

     syntax Scope ::= "none" | FileScope
     syntax FileScope ::= "fileScope"

     syntax Status ::= "initializingTu" | "mainCalled" | "mainExited" | "terminated"

     syntax LanguageLinkage ::= "CLinkage" | "CPPLinkage"

     syntax KItem ::= allowInit(K)
     syntax Expr ::= allowInit(Expr)

     syntax KItem ::= CodeLoc(K, CabsLoc)

endmodule
