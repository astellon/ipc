#include <stdio.h>
#include <stdlib.h>

#include <sys/ipc.h>

#include "./define.h"

int main() {
  const char* libipccr = "./libipc.cr";

  FILE* fp = fopen(libipccr, "w");

  if (fp == NULL) {
    fprintf(stderr, "Cannot open %s", libipccr);
    exit(-1);
  }

  PUTS("lib LibC");

  SPACE(2); DEF_ALIAS_INTEGER("KeyT", key_t);

  __EMPTY_LINE__;

  SPACE(2); PUTS("# memory layout of `ipc_perm`");
  SPACE(2); DEF_STRUCT(ipc_perm);
  SPACE(2); DEF_FIELD_OFFSET(ipc_perm, uid);
  SPACE(2); DEF_FIELD_OFFSET(ipc_perm, gid);
  SPACE(2); DEF_FIELD_OFFSET(ipc_perm, cuid);
  SPACE(2); DEF_FIELD_OFFSET(ipc_perm, cgid);
  SPACE(2); DEF_FIELD_OFFSET(ipc_perm, mode);

  __EMPTY_LINE__;

  {
    struct ipc_perm tmp;
    SPACE(2); PUTS("# the type of `mode`");
    SPACE(2); DEF_TYPE_OF_VALUE("Ipc_Perm", "Mode", tmp.mode);
  }

  __EMPTY_LINE__;

  SPACE(2); DEF_CONST(IPC_CREAT);
  SPACE(2); DEF_CONST(IPC_EXCL);
  SPACE(2); DEF_CONST(IPC_NOWAIT);

  __EMPTY_LINE__;

  SPACE(2); DEF_CONST(IPC_PRIVATE);

  __EMPTY_LINE__;

  SPACE(2); DEF_CONST(IPC_RMID);
  SPACE(2); DEF_CONST(IPC_SET);
  SPACE(2); DEF_CONST(IPC_STAT);

  __EMPTY_LINE__;

  SPACE(2); PUTS("fun ftok(pathname : UInt8*, proj_id : Int32) : KeyT");

  PUTS("end");

  fclose(fp);
}
