// macros to output code
#define PUTS(str) fprintf(fp, "%s\n", str)
#define SPACE(N) for(int i = 0; i < N; i++) { fprintf(fp, " "); }
#define __EMPTY_LINE__ fprintf(fp, "\n")

#define ISSIGNED(type) ((type)(~(type)0) < (type)0)
#define OFFSET_OF(type, field) ((char*)&((type*)0)->field - (char*)0)

#define DEF_ALIAS_INTEGER(alias, type)\
  if (ISSIGNED(type)) {\
    fprintf(fp, "alias %s = Int%d\n", alias, sizeof(key_t)*8);\
  } else {\
    fprintf(fp, "alias %s = UInt%d\n", alias, sizeof(key_t)*8);\
  }

#define DEF_CONST(constant) fprintf(fp, #constant " = Int32.new(%d)\n", constant);

#define DEF_STRUCT(type) fprintf(fp, "Sizeof_struct_%s = %d\n", #type, sizeof(struct type))
#define DEF_FIELD_OFFSET(type, field) fprintf(fp, "Offsetof_%s_%s = %d\n", #type, #field, (long)OFFSET_OF(struct type, field))

#define DEF_TYPE_OF_VALUE(structure, field, value)\
  if ((value = -1) < 0){\
    fprintf(fp, "alias Typeof_%s_%s = Int%d\n", structure, field, sizeof(value)*8);\
  } else {\
    fprintf(fp, "alias Typeof_%s_%s = UInt%d\n", structure, field, sizeof(value)*8);\
  }
