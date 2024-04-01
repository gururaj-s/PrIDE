run:
	echo "Compiling Analytical Model"; cd analytical; make; ./loss_probability_analytical > output/output.txt; cat output/output.txt; cd -
	echo ""
	echo "Compiling Monte Carlo Model"; cd monte_carlo; make;  ./sim > output/output.txt; cat output/output.txt; cd -
	echo ""
