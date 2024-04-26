#include <stdio.h>
#include <assert.h>
#include <cmath>

#define MAX_SIZE 16

typedef unsigned uns;

uns TREFI =   79; // how many ACTS in TREFI window
double INS_PROB = 1/(double)(TREFI);


//--- variables for prob of n insertions in TREFI window
double prob_n[MAX_SIZE+1];
double cprob_n[MAX_SIZE+1];

double MCVals[MAX_SIZE][MAX_SIZE]; // matrix
double MCSoln[MAX_SIZE]; // steady state probability


/////////////////////////////////////////////////////
/////////////////////////////////////////////////////

double calc_binomial_prob(uns n, uns k, double p){

  double log_ans=0;

  for(uns ii=1; ii<=n; ii++){
    log_ans += log(ii); // N-Factorial
  }

  for(uns ii=1; ii<=(n-k); ii++){
    log_ans -= log(ii); // (N-K)-Factorial
  }

  for(uns ii=1; ii<=k; ii++){
    log_ans -= log(ii); // K-Factorial
  }
  
  log_ans += k*log(p); // p-to-the-K
  log_ans += (n-k)*log(1-p); // (p-1)-to-the-(N-K)

  return exp(log_ans);
}

/////////////////////////////////////////////////////
/////////////////////////////////////////////////////

void  init(void){
  uns ii;

  for(ii=0; ii<= MAX_SIZE; ii++){
    prob_n[ii] = calc_binomial_prob(TREFI, ii, INS_PROB);
  }

  double balance=1;

  for(ii=0; ii< MAX_SIZE; ii++){
    cprob_n[ii] = balance;
    balance -= calc_binomial_prob(TREFI, ii, INS_PROB);
  }
}

/////////////////////////////////////////////////////
/////////////////////////////////////////////////////

double calc_lossprob(uns capacity, uns ptr, uns size){
  double s_lossprob=0;
  uns full_th = (capacity-size)+ptr; //-- how many insertion for buffer to full till ptr?

  //--- escape clause
  if(ptr==0){
    s_lossprob = cprob_n[full_th+1];
    return s_lossprob; // failure if insert > leftover 
  }
 
  //--- ptr is non-zero here (3 cases: lt/eq/gt leftover, 

  //---- case A
  double A_lossprob=0;

  for(uns insert=0; insert< full_th; insert++){
    double my_lossprob=0;
    double event_prob = prob_n[insert];
    
    uns new_size = (size + insert);
    if(new_size > capacity){
      new_size = capacity; // overwriting older entries
    }
    
    uns new_ptr = ptr;
    uns remain = capacity-size;
    if(insert > remain){
      new_ptr -= (insert-remain);
      assert(new_ptr<ptr);
    }

    // mitigation (new_ptr should be > 1)
    new_ptr--;
    new_size--;
    double case_fail_prob = calc_lossprob(capacity, new_ptr, new_size);
    my_lossprob = event_prob * case_fail_prob;

    A_lossprob += my_lossprob;
  }

   //---- case B
  double B_lossprob=0; //if we insert exactly equal to full_th, mitigation

  //---- case C 
  double C_lossprob = cprob_n[full_th+1]; // s or more

  s_lossprob = A_lossprob+B_lossprob+C_lossprob;  
    
  return s_lossprob;
}

/////////////////////////////////////////////////////
/////////////////////////////////////////////////////

void init_markov_chain(uns size){
  uns ii, jj;

  for(ii=0; ii<size; ii++){
    for(jj=0; jj<size; jj++){
      MCVals[ii][jj]=0; // zeroed out
    }
  }

  // ----- Row-0 is special------
  double balance=1;

  MCVals[0][0] = prob_n[0]+prob_n[1];
  balance -= (MCVals[0][0]);

  for(jj=1; jj<size-1; jj++){
    MCVals[0][jj]=prob_n[jj+1];
    balance -= MCVals[0][jj];
  }

  MCVals[0][size-1] = balance;

  // ----- All other rows------
  for(ii=1; ii<size; ii++){
    balance=1;
    for(jj=0; jj<size-1; jj++){
      double val=0;
      if( jj >= (ii-1) ){
	val = prob_n[jj-ii+1];
      }
      MCVals[ii][jj]=val;
      balance -= MCVals[ii][jj];
    }
    MCVals[ii][size-1] = balance;
  }

  //---- compute the stable MC state using MatMul
  double mc_soln[size];
  double new_mc_soln[size];
  
  for(ii=0; ii<size; ii++){
    mc_soln[ii] = 1/(double)(size);
    new_mc_soln[ii] = 0;
  }
  
  for(uns iterid=0; iterid<1000; iterid++){
    for(ii=0; ii<size; ii++){
      for(jj=0; jj<size; jj++){
	new_mc_soln[ii] += (mc_soln[jj] * MCVals[jj][ii]);
      }
    }
    
    for(ii=0; ii<size; ii++){
      mc_soln[ii] = new_mc_soln[ii];
      new_mc_soln[ii]=0;
    }
  }
  
  for(ii=0; ii<size; ii++){
    MCSoln[ii] = mc_soln[ii];
  }
}


/////////////////////////////////////////////////////
/////////////////////////////////////////////////////

void print_loss_prob(uns window_size){
  TREFI = window_size;
  INS_PROB = 1/(double)(TREFI);

  init();
  printf("\n***********Printing Table-III***********\n", window_size);

  printf("\n***** LossProbability for Window-Size: %u ******\n", window_size);

  double loss_single_entry = 1-pow(1-INS_PROB, TREFI-1);

  printf("Capacity: 1\tLossProb: %5.4f\n", loss_single_entry);

  int sizes[] = {2, 4, 8, 16};
//  for(uns capacity=2; capacity<=16; capacity+=1){
  for(uns i=0; i<4; i+=1){
    uns capacity = sizes[i];
    init_markov_chain(capacity);
    double s_lossprob=0;
    for(uns s=0; s< capacity ; s++){
      double my_lossprob = calc_lossprob(capacity, s, s+1);
      s_lossprob += (MCSoln[s]*my_lossprob);
    }
    printf("Capacity: %u\tLossProb: %5.4f\n", capacity, s_lossprob);
  }

  printf("\n");
}


/////////////////////////////////////////////////////
/////////////////////////////////////////////////////

int main(int argc, char* argv[]){

  //NoRFM
  print_loss_prob(79);

  //RFM-40
//  print_loss_prob(40);

  //RFM-16
//  print_loss_prob(16);

}



