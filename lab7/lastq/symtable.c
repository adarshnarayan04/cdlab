//  This contains a main() to test the symbol table in symtabfunctions.c
#include "symtablefuncs.c"

int symtab(int* size, struct element* stab, char* pt, char* name, char* type, int bytes, int* count, int* index) {
    char *symbol = (char *)malloc(sizeof(*name));
    strcpy(symbol, name);
    *index = find(symbol, stab);
    free(symbol);

    if (*index == -1) {
        append(stab, name, type, bytes);
        stab[0].width = ++(*count);
    } else {
        printf("Duplicate Error: Input Symbol %s exists at index %d %s \n", name, *index, stab[*index].name);
    }
}
