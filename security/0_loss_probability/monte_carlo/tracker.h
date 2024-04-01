#ifndef TRACKER_H
#define TRACKER_H

#include "types.h"
#include "mtrand.h"
#include <stdlib.h>

typedef struct Tracker_Entry Tracker_Entry;
typedef struct Tracker Tracker;

#define MAX_POS 1024

struct Tracker_Entry {
  uns   pos; // which position in tREFI window?
  uns   addr; 
};



///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////


struct Tracker{
  Tracker_Entry *entries;
  uns           num_entries;
  uns           num_valids;
  uns           ptr;
  
  uns64         s_inserts; 
  uns64         s_loss;
  uns64         s_inserts_pos[MAX_POS];
  uns64         s_loss_pos[MAX_POS];
};

///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////

Tracker *tracker_new(uns entries);
void     tracker_insert(Tracker *t, uns addr, uns pos);
uns      tracker_remove(Tracker *t);
double   tracker_get_loss_prob(Tracker *t);
void     tracker_print_stats(Tracker *t);


///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////

#endif 
