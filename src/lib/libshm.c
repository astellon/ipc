#include <stdio.h>
#include <stdlib.h>

#include <sys/shm.h>

#include "./define.h"

int main() {
  const char* libshmcr = "./libshm.cr";

  FILE* fp = fopen(libshmcr, "w");

  if (fp == NULL) {
    fprintf(stderr, "Cannot open %s", libshmcr);
    exit(-1);
  }

  PUTS("lib LibC");

  // check if shmatt_t is signed
  SPACE(2); DEF_ALIAS_INTEGER("ShmattT", shmatt_t);

  __EMPTY_LINE__;

  SPACE(2); PUTS("# memory layout of `shmid_ds`");
  SPACE(2); DEF_STRUCT(shmid_ds);
  SPACE(2); DEF_FIELD_OFFSET(shmid_ds, shm_perm);
  SPACE(2); DEF_FIELD_OFFSET(shmid_ds, shm_segsz);
  SPACE(2); DEF_FIELD_OFFSET(shmid_ds, shm_lpid);
  SPACE(2); DEF_FIELD_OFFSET(shmid_ds, shm_cpid);
  SPACE(2); DEF_FIELD_OFFSET(shmid_ds, shm_nattch);
  SPACE(2); DEF_FIELD_OFFSET(shmid_ds, shm_atime);
  SPACE(2); DEF_FIELD_OFFSET(shmid_ds, shm_dtime);
  SPACE(2); DEF_FIELD_OFFSET(shmid_ds, shm_ctime);

  __EMPTY_LINE__;

  {
    struct shmid_ds tmp;
    SPACE(2); PUTS("# the type of `shm_atime`, `shm_dtime` and `shm_ctime`");
    SPACE(2); DEF_TYPE_OF_VALUE("Shmid_Ds", "Time", tmp.shm_atime);
  }

  __EMPTY_LINE__;

  SPACE(2); DEF_CONST(SHM_R);
  SPACE(2); DEF_CONST(SHM_W);

  __EMPTY_LINE__;

  SPACE(2); DEF_CONST(SHM_RDONLY);
  SPACE(2); DEF_CONST(SHM_RND);

  __EMPTY_LINE__;

  SPACE(2); DEF_CONST(SHM_LOCK);
  SPACE(2); DEF_CONST(SHM_UNLOCK);

  __EMPTY_LINE__;

  SPACE(2); PUTS("fun shmget(key : KeyT, size : SizeT, flag : Int) : Int");
  SPACE(2); PUTS("fun shmat(id : Int, addr : Void*, flag : Int) : Void*");
  SPACE(2); PUTS("fun shmctl(id : Int, cmd : Int, buf : Void*) : Int");
  SPACE(2); PUTS("fun shmdt(addr : Void*) : Int");

  SPACE(2); PUTS("# NOTE: the type of the argument `buf` of shmctl is shmid_ds");

  PUTS("end");

  fclose(fp);
}
