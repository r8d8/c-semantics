/* Generated by CIL v. 1.3.7 */
/* print_CIL_Input is true */

struct s {
   char text[11] ;
   int flag ;
};
extern  __attribute__((__nothrow__)) char *strcpy(char * __restrict  __dest , char const   * __restrict  __src )  __attribute__((__nonnull__(1,2),
__leaf__)) ;
extern  __attribute__((__nothrow__)) int strcmp(char const   *__s1 , char const   *__s2 )  __attribute__((__pure__,
__nonnull__(1,2), __leaf__)) ;
extern  __attribute__((__nothrow__, __noreturn__)) void abort(void)  __attribute__((__leaf__)) ;
extern  __attribute__((__nothrow__, __noreturn__)) void exit(int __status )  __attribute__((__leaf__)) ;
struct s cell  ;
int check(struct s p ) 
{ int tmp ;

  {
  if (p.flag != 99) {
    return (1);
  }
  tmp = strcmp((char const   *)(p.text), "0123456789");
  return (tmp);
}
}
int main(void) 
{ int tmp ;

  {
  cell.flag = 99;
  strcpy((char * __restrict  )(cell.text), (char const   * __restrict  )"0123456789");
  tmp = check(cell);
  if (tmp) {
    abort();
  }
  exit(0);
}
}