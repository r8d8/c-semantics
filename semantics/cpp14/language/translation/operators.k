module CPP-OPERATORS-SYNTAX
     imports CPP-SORTS
     syntax Expr ::= builtinOperator(OpId, Expr, Init) [function]
                   | builtinOperator(OpId, Expr) [function, klabel(builtinOperator2)]
endmodule

module CPP-OPERATORS
     imports CPP-OPERATORS-SYNTAX
     imports BASIC-K
     imports CPP-ABSTRACT-SYNTAX
     imports CPP-SYNTAX
     imports CPP-TRANSLATION-NAME-SYNTAX
     imports CPP-TYPING-EXPR-SYNTAX
     imports CPP-TYPING-SYNTAX

     rule BinaryOperator(O::OpId, E1::Expr, E2::Init)
          => #BinaryOperator(O, E1, E1, E2, E2)

     rule UnaryOperator(O::OpId, E1::Expr)
          => #UnaryOperator(O, E1, E1)

     syntax Expr ::= #BinaryOperator(OpId, Expr, TypeExpr, Init, K)
                   | #UnaryOperator(OpId, Expr, TypeExpr)
     context #BinaryOperator(_, _, (HOLE:TypeExpr => typeof(HOLE)), _, _) [result(CPPDType)]
     context #BinaryOperator(O::OpId, _, _, _, (HOLE:TypeExpr => typeof(HOLE)))
             requires O =/=K operator-> [result(CPPDType)]
     context #UnaryOperator(_, _, (HOLE:TypeExpr => typeof(HOLE))) [result(CPPDType)]

     rule #BinaryOperator(operator->, E1::Expr, T1:CPPType, E2::Init, _)
          => builtinOperator(operator->, E1, E2)
          requires notBool isCPPClassType(T1) andBool notBool isCPPEnumType(T1)

     rule #BinaryOperator(O::OpId, E1::Expr, T1:CPPType, E2::Init, T2:CPPType)
          => builtinOperator(O, E1, E2)
          requires notBool isCPPClassType(T1) andBool notBool isCPPClassType(T2)
               andBool notBool isCPPEnumType(T1) andBool notBool isCPPEnumType(T2)

     rule #BinaryOperator(O::OpId, E1::Expr, T1:CPPType, E2::Init, T2:CPPType)
          => resolveOverloadedOperator(O, E1, T1, E2, T2)
          requires isCPPClassType(T1) orBool isCPPClassType(T2)
               orBool isCPPEnumType(T1) orBool isCPPEnumType(T2)

     rule #UnaryOperator(O::OpId, E1::Expr, T1:CPPDType)
          => builtinOperator(O, E1)
          requires notBool isCPPClassType(T1) andBool notBool isCPPEnumType(T1)

     rule #UnaryOperator(O::OpId, E1::Expr, T1:CPPDType)
          => resolveOverloadedOperator(O, E1, T1)
          requires isCPPClassType(T1) orBool isCPPEnumType(T1)
 

     rule builtinOperator(operator=, E1::Expr, E2::Init)
          => E1 := E2
     rule builtinOperator(operator[], E1::Expr, E2::Expr)
          => E1[E2]
     rule builtinOperator(operator->, E1::Expr, E2::Name)
          => E1 -> no-template E2
     rule builtinOperator(operator+, E1::Expr, E2::Expr)
          => E1 + E2
     rule builtinOperator(operator-, E1::Expr, E2::Expr)
          => E1 - E2
     rule builtinOperator(operator*, E1::Expr, E2::Expr)
          => E1 * E2
     rule builtinOperator(operator/, E1::Expr, E2::Expr)
          => E1 / E2
     rule builtinOperator(operator%, E1::Expr, E2::Expr)
          => E1 % E2
     rule builtinOperator(operator||, E1::Expr, E2::Expr)
          => E1 || E2
     rule builtinOperator(operator&&, E1::Expr, E2::Expr)
          => E1 && E2
     rule builtinOperator(operator&, E1::Expr, E2::Expr)
          => E1 & E2
     rule builtinOperator(operator|, E1::Expr, E2::Expr)
          => E1 | E2
     rule builtinOperator(operator^, E1::Expr, E2::Expr)
          => E1 ^ E2
     rule builtinOperator(operator==, E1::Expr, E2::Expr)
          => E1 == E2
     rule builtinOperator(operator!=, E1::Expr, E2::Expr)
          => E1 != E2
     rule builtinOperator(operator<, E1::Expr, E2::Expr)
          => E1 < E2
     rule builtinOperator(operator<=, E1::Expr, E2::Expr)
          => E1 <= E2
     rule builtinOperator(operator>, E1::Expr, E2::Expr)
          => E1 > E2
     rule builtinOperator(operator>=, E1::Expr, E2::Expr)
          => E1 >= E2
     rule builtinOperator(operator+=, E1::Expr, E2::Expr)
          => E1 += E2
     rule builtinOperator(operator-=, E1::Expr, E2::Expr)
          => E1 -= E2
     rule builtinOperator(operator*=, E1::Expr, E2::Expr)
          => E1 *= E2
     rule builtinOperator(operator/=, E1::Expr, E2::Expr)
          => E1 /= E2
     rule builtinOperator(operator%=, E1::Expr, E2::Expr)
          => E1 %= E2
     rule builtinOperator(operator^=, E1::Expr, E2::Expr)
          => E1 ^= E2
     rule builtinOperator(operator&=, E1::Expr, E2::Expr)
          => E1 &= E2
     rule builtinOperator(operator|=, E1::Expr, E2::Expr)
          => E1 |= E2
     rule builtinOperator(operator<<, E1::Expr, E2::Expr)
          => E1 << E2
     rule builtinOperator(operator>>, E1::Expr, E2::Expr)
          => E1 >> E2
     rule builtinOperator(operator<<=, E1::Expr, E2::Expr)
          => E1 <<= E2
     rule builtinOperator(operator>>=, E1::Expr, E2::Expr)
          => E1 >>= E2
     rule builtinOperator(operator,, E1::Expr, E2::Expr)
          => Comma(E1, E2)
     rule builtinOperator(operator_++, E1::Expr)
          => E1 ++
     rule builtinOperator(operator_--, E1::Expr)
          => E1 --
     rule builtinOperator(operator++_, E1::Expr)
          => ++ E1
     rule builtinOperator(operator--_, E1::Expr)
          => -- E1
     rule builtinOperator(operator!, E1::Expr)
          => ! E1
     rule builtinOperator(operator-, E1::Expr)
          => - E1
     rule builtinOperator(operator&, E1::Expr)
          => & E1
     rule builtinOperator(operator*, E1::Expr)
          => * E1

endmodule
