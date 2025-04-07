//  This contains a main() to test the symbol table in symtabfunctions.c
  #include "symtablefuncs.c"
 
  int symtable_init (int argc, char* argv[])
  { int size = 50;
    struct element stab[size];
    initialize(stab, size);
    char *ptr =(char*)malloc(sizeof("Global")); ptr = stab[0].name;
    strcpy(ptr, "Global"); 
    ptr = (char*)malloc(sizeof("Symbol Table")); ptr = stab[0].type;
    strcpy(ptr, "Symbol Table");

    // initialize(stab, size);
    FILE *fin = fopen(argv[1],"r");
    char name[20], type[20];
    int bytes;
    int count = 0, index = -1;
    while ( fscanf(fin, "%s %s", name, type) != EOF)//changed so that does not require size as input
    { //char* symbol = (char*) malloc(sizeof(name));
      // strcpy(symbol, name); free(symbol);
      // symbol = (char*) malloc(sizeof(type));
      // strcpy(symbol, type); free(symbol);
      index = find(name, stab);
      if (index == -1) // name does not exist in table insert
      { 
        bytes=(strcmp(type, "int") == 0 ? 4 :
      (strcmp(type, "float") == 0 ? 4 : 
      (strcmp(type, "double") == 0 ? 8 :
      (strcmp(type,"char") == 0 ? 1 : -1 )))); 

        append(stab, name, type, bytes); 
        stab[0].width = ++count;
      }
      else
      { // symbol exists - denote error
        printf(" Duplicate Error : Input Symbol %s exists at index %d %s \n",
                 name, index, stab[index].name);
      }
    } 
    printf(" Total no. of symbols read = %d lastindex %d \n", stab[0].width, lastindex);
    display(stab);
    return 0;
  }
