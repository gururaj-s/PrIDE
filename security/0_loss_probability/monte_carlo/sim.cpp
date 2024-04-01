#include <stdio.h>
#include <assert.h>
#include <cmath>

#include "mtrand.h"
#include "types.h"
#include "tracker.h"

#define MAX_ITER   (100*1000*1000)

uns    TREFI                =  79; // 79 activations in tREFI possible
uns    TRACKER_SIZE         =  6; 

MTRand *mtrand=new MTRand();
Tracker *t; 

uns64 act_count; // how many activiations


/////////////////////////////////////////////////////
/////////////////////////////////////////////////////

void do_refresh(void){
  tracker_remove(t);
}

/////////////////////////////////////////////////////
/////////////////////////////////////////////////////

void sim_monte_carlo(uns tracker_size){

  double PROB_INSERTION       = (double)(1)/(double)(TREFI);

  act_count=0;
  t = tracker_new(tracker_size);
  
  while(act_count/TREFI < MAX_ITER){

    if(act_count % TREFI == 0){
      do_refresh();
    }

    if(mtrand->rand() < PROB_INSERTION){
      uns pos  = act_count%TREFI; // -- which position in tREFI window?
      uns addr = pos; // this value not relevant
      tracker_insert(t, addr, pos);
    }

    act_count++;
  }

  double loss_prob_max = tracker_get_loss_prob(t);
  printf("Capacity: %d\tLossProb: %5.4f\n", tracker_size, loss_prob_max);
  
  
}

/////////////////////////////////////////////////////
/////////////////////////////////////////////////////

int main(int argc, char* argv[]){
  uns myseed=123;
  mtrand->seed(myseed);

  uns trefis[] = {79, 40, 16};
  uns sizes[] = {1, 2, 4, 8, 16};

//  for (uns i=0; i<3; i++)
  for (uns i=0; i<1; i++)
  {
      TREFI = trefis[i];
      
      printf("***** LossProbability for Window-Size: %d ******\n", TREFI);
  
      for(uns ii=0; ii<=4; ii++){
          sim_monte_carlo(sizes[ii]);
      }
      printf("\n\n");
  }
  
  return 0;
}


