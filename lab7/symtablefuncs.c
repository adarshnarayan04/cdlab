  #include <stdio.h>
  #include <string.h>
  #include <stdlib.h>
  #include <stdbool.h>

  // working with a linked list

  struct element 
  { char name[20];
    char type[20];
    int width;
    // struct element * symtabptr;
  };
  // list of functions
  struct element symtab[50]; // max 50 elements in one symbol table
  int lastindex;
  void initialize (struct element symtab[], int size)
  {  strcpy(symtab[0].name, ""); strcpy(symtab[0].type, ""); symtab[0].width = 0;
     // symtab[0].symtabptr = 0;  // initialize all fields in the header of the table
     for (int i = 1; i < size; i++) // initialize all fields in rows from 1 to 49
     {  strcpy(symtab[i].name, ""); strcpy(symtab[i].type, ""); symtab[i].width = 0; 
        // symtab[i].offset = 0; // symtab[i].symtabptr = 0;
     }
     lastindex = 0; // keeps track of the last index that has been used in the symtab
     return;
  }
  
  bool isempty ( struct element table[] )
  { if (lastindex == -1) return true; else return false; }

  int length (struct element table[] ) { return lastindex; }
 
  int  find (char* id, struct element symtab[]) 
  // look up id in symtab ; return value is index found
  { int index = -1;    // assume id is not present in table
    char* idname = (char*) malloc(sizeof(id));
    strcpy(idname, id);
    for (int i = 1; i <= lastindex; i++)
    { if (strcmp(idname, symtab[i].name) == 0) // id exists in table
      { index = i;
        return index;
      }
    };
    return index; // id not found in symtab
  }
          
  // append function to insert an element at the end of a list

  void append(struct element stab[], char *id, char* typ, int bytes)
  { char* idname = (char*) malloc(sizeof(id));
    char* tname = (char*) malloc(sizeof(typ));
    strcpy(idname, id); strcpy(tname, typ); ++lastindex;
    strcpy(stab[lastindex].name, idname); strcpy(stab[lastindex].type, tname);
    stab[lastindex].width = bytes; // stab[lastindex].offset = reladdr,
    //stab[lastindex].symtabptr = ptr;
    return;
  }    
    
  // a function to display the symbol table

  void display (struct element stab[])
  { printf(" Display Contents of Symbol Table of Size: %d bytes \n", 
      stab[0].width);
    //if (stab[0].symtabptr == 0) printf (" Global Symbol Table at scope level 0 \n");
    //else display(stab[0].symtabptr);
    for ( int i = 1 ; i <= lastindex ; i++ )
     printf(" Index [%d]  %s  %s  %d  \n", 
        i, stab[i].name, stab[i].type, stab[i].width );
  }
