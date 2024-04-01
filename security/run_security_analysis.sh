# Report the loss probability
cd 0_loss_probability/
make run ; cd - ;

# Plot Figure 8
cd 0_loss_probability/analytical;
python3 loss_1entry.py ;
cd - ; 

# Report the reliability data
cd 1_reliability/
make
./sim-reliability
