/* Generated by CIL v. 1.3.7 */
/* print_CIL_Input is true */

extern  __attribute__((__nothrow__, __noreturn__)) void abort(void)  __attribute__((__leaf__)) ;
extern  __attribute__((__nothrow__, __noreturn__)) void exit(int __status )  __attribute__((__leaf__)) ;
char foo(char *bar ) 
{ 

  {
  return (*(bar + 1));
}
}
int main(void) 
{ char tmp ;

  {
  tmp = foo((char *)"xy");
  if ((int )tmp != 121) {
    abort();
  }
  exit(0);
}
}