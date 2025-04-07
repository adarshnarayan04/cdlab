#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

// working with a linked list

struct element
{
  char name[20];
  char type[20];
  int width;
  // struct element * symtab1ptr;
};
// list of functions
struct element symtab1[50]; // max 50 elements in one symbol table
int lastindex;
void initialize(struct element symtab1[], int size)
{
  strcpy(symtab1[0].name, "");
  strcpy(symtab1[0].type, "");
  symtab1[0].width = 0;
  // symtab1[0].symtab1ptr = 0;  // initialize all fields in the header of the table
  for (int i = 1; i < size; i++) // initialize all fields in rows from 1 to 49
  {
    strcpy(symtab1[i].name, "");
    strcpy(symtab1[i].type, "");
    symtab1[i].width = 0;
    // symtab1[i].offset = 0; // symtab1[i].symtab1ptr = 0;
  }
  lastindex = 0; // keeps track of the last index that has been used in the symtab1
  return;
}

bool isempty(struct element table[])
{
  if (lastindex == -1)
    return true;
  else
    return false;
}

int length(struct element table[]) { return lastindex; }

int find(char *id, struct element symtab1[])
// look up id in symtab1 ; return value is index found
{
  int index = -1; // assume id is not present in table
  char *idname = (char *)malloc(sizeof(id));
  strcpy(idname, id);
  for (int i = 1; i <= lastindex; i++)
  {
    if (strcmp(idname, symtab1[i].name) == 0) // id exists in table
    {
      index = i;
      return index;
    }
  };
  return index; // id not found in symtab1
}

// append function to insert an element at the end of a list

void append(struct element stab[], char *id, char *typ, int bytes)
{
  char *idname = (char *)malloc(sizeof(id));
  char *tname = (char *)malloc(sizeof(typ));
  strcpy(idname, id);
  strcpy(tname, typ);
  ++lastindex;
  strcpy(stab[lastindex].name, idname);
  strcpy(stab[lastindex].type, tname);
  stab[lastindex].width = bytes; // stab[lastindex].offset = reladdr,
  // stab[lastindex].symtab1ptr = ptr;
  return;
}

// a function to display the symbol table

void display(struct element stab[])
{
  printf(" Display Contents of Symbol Table of Size: %d bytes \n",
         stab[0].width);
  // if (stab[0].symtab1ptr == 0) printf (" Global Symbol Table at scope level 0 \n");
  // else display(stab[0].symtab1ptr);
  for (int i = 1; i <= lastindex; i++)
    printf(" Index [%d]  %s  %s  %d  \n",
           i, stab[i].name, stab[i].type, stab[i].width);
}
