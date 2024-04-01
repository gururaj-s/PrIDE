import numpy as np
import matplotlib.pyplot as plt

# Define the equation
def L_K(K, W):
    return 1 - (1 - 1/W)**(W - K)

# Define values for K and W
W = 79
K_values = np.arange(1, 80)

# Calculate L_K values
L_K_values = [L_K(K, W) for K in K_values]

# Set the figure size
plt.figure(figsize=(8, 3))

# Plot L_K vs K with red dots
plt.scatter(K_values, L_K_values, color='red', s=20)  # s parameter defines the size of dots
plt.xlabel('Position of the Attacked Line (K)')
plt.ylabel('Loss Probability')
plt.grid(True)
plt.xlim(0, 80)  # Set the x-axis range
plt.ylim(0, 0.7)  # Set the y-axis range
plt.tight_layout()  # Add tight layout
plt.savefig('output/fig8_loss_1entry.pdf')  # Save the figure as loss_prob_1entry.pdf
plt.show()
