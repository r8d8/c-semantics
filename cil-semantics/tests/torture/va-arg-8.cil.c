/* Generated by CIL v. 1.3.7 */
/* print_CIL_Input is true */

typedef __builtin_va_list __gnuc_va_list;
typedef __gnuc_va_list va_list;
typedef long long INT64;
/* compiler builtin: 
   void __builtin_va_end(__builtin_va_list  ) ;  */
/* compiler builtin: 
   void __builtin_va_arg(__builtin_va_list  , unsigned long  , void * ) ;  */
/* compiler builtin: 
   void __builtin_va_start(__builtin_va_list  ) ;  */
extern  __attribute__((__nothrow__, __noreturn__)) void abort(void)  __attribute__((__leaf__)) ;
extern  __attribute__((__nothrow__, __noreturn__)) void exit(int __status )  __attribute__((__leaf__)) ;
__inline void debug(int i1 , int i2 , int i3 , int i4 , int i5 , int i6 , int i7 ,
                    int i8 , int i9  , ...) 
{ va_list ap ;
  int tmp ;
  INT64 tmp___0 ;

  {
  __builtin_va_start(ap, i9);
  tmp = __builtin_va_arg(ap, int );
  if (tmp != 10) {
    abort();
  }
  tmp___0 = __builtin_va_arg(ap, INT64 );
  if (tmp___0 != 20014547621496LL) {
    abort();
  }
  __builtin_va_end(ap);
  return;
}
}
int main(void) 
{ 

  {
  debug(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 20014547621496LL);
  exit(0);
}
}