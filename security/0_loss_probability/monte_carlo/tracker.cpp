
#include <cmath>
#include <cassert>
#include "tracker.h"

extern MTRand *mtrand;
extern uns TREFI;

///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////

Tracker *tracker_new(uns entries){
  Tracker *t = (Tracker *) calloc (1, sizeof (Tracker));
  t->entries  = (Tracker_Entry *) calloc (entries, sizeof(Tracker_Entry));
  t->num_entries = entries;
  return t;
}

///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////

uns  tracker_remove(Tracker *t){
  uns pos=MAX_UNS;
  
  if(t->num_valids > 0){
    pos = t->entries[t->ptr].pos;
    t->ptr = (t->ptr+1)%(t->num_entries);
    t->num_valids--;
  }

  return pos;
}

///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////

void   tracker_insert(Tracker *t, uns addr, uns pos){

  if(t->num_valids == t->num_entries){
    uns victim_pos = tracker_remove(t); // loss
    t->s_loss++;
    t->s_loss_pos[victim_pos]++;
  }

  uns index = (t->ptr + t->num_valids) % (t->num_entries);
  t->entries[index].addr = addr;
  t->entries[index].pos = pos;
  t->num_valids++;;
 
  t->s_inserts++;
  t->s_inserts_pos[pos]++;
}

///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////

void     tracker_print_stats(Tracker *t){

  double loss_prob_max=0;

  // --- there are 79 positions, lets find the one with highest lossprob
  for(uns ii=0; ii < TREFI ; ii++){
    double my_loss_prob=  (double)(t->s_loss_pos[ii])/(t->s_inserts_pos[ii]);
    if(loss_prob_max < my_loss_prob){
      loss_prob_max = my_loss_prob;
    }
  }

  printf("LOSS_PROB_WORST_POS:\t %5.4f\n", loss_prob_max);

  //  double loss_prob = (double)(t->s_loss)/(t->s_inserts);
  //  printf("LOSS_PROB_AVG_POS:\t %5.4f\n", loss_prob);

  printf("\n");
}



///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////

double     tracker_get_loss_prob(Tracker *t){

  double loss_prob_max=0;

  // --- there are 79 positions, lets find the one with highest lossprob
  for(uns ii=0; ii < TREFI ; ii++){
    double my_loss_prob=  (double)(t->s_loss_pos[ii])/(t->s_inserts_pos[ii]);
    if(loss_prob_max < my_loss_prob){
      loss_prob_max = my_loss_prob;
    }
  }

  return loss_prob_max;
}
