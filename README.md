# GVAN
Package Library for Inverse Vandermonde Calculation

This package contains the code used to create the analysis and figures from:  

Mahdi S. Hosseini, Alfred Chen and Konstantinos N. Plataniotis "On the Closed Form Expression Of Elementary Symmetric Polynomials and the Inverse of Vandermonde Matrix," submitted to SIAM Journal On Scientific Computing, 2019.

Folders:  
Utilities - the main source codes as well as some programs to help readability of the demos.  
Third party codes - the Matlab implemented codes for other inverse or ESP solutions  
Demo examples - the demo codes to create the figures seen in the paper  
Data - saved Fekete node calculations to reduce calculation time  

Acronyms in file names:  
ESP - Elementary Symmetric Polynomial  
INV - Inverse  
UC - Unit Circle  
Interp - Interpolation  
Acc - Accuracy  
Polyfit - Polynomial Fitting  
NMSE - Normalized Mean Squared Error  

Demo:  
The changeable parameters are located at the top of every demo file. Each program is standalone and can be individually ran to output results specifically related to the figure in its name. Demos starting with “UC” are relating to the unit circle analysis done on the ESP solutions. Demos starting with “Interp” are the interpolation analysis relating to the inverse methods.  

Interp_2D_Plots_Fig5 - Creates the 2D plots for Figure 5  
Interp_3D_Plots_Fig5 - Creates the 3D plots for Figure 5  
Interp_NMSE_Plots_Fig4 - This function creates an NMSE vs sample size plot seen in Figure 4  
Interp_Speed_Fig6 - Calculates and creates figure 6  
UC_Acc_Fig2a - This demo calculates and plots the Accuracy of the proposed ESP solution over UC samples. Figure 2a  
UC_Noise_Analysis_Fig3 - calculates the NMSE of a vandermonde inverse method quantitatively. Complements Figure 3.  
UC_Speed_Fig2b - Calculates and plots the computation speed of the proposed ESP solution over the UC samples. The plot corresponds to figure 2b.  
UC_Visual_Fig1 - Calculates and visualizes the results from various ESP solutions  

Utilities:  
analytical_function - produces the three true functions,f, used for experimental analysis  
big_S - Used to incorporate various ESP solutions to solve the proposed Vandermonde inverse.  
ESP_Closed - Closed Form, proposed ESP solution. Listed as Theorem 2.1 in the paper.  
ESP_Selector - transforms strings to integer representation for the ESP solutions.  
full_ESP_thrm1 - Produces a full ESP matrix using the proposed ESP solution. Needed for Eisinberg et.al. inverse method when it calls the proposed ESP solution.  
igvan - An inverse caller that returns an inverse vandermonde using a specified inverse method and a specified ESP solution.  
INV_Closed - Closed Form Vandermonde Inverse from Theorem 2.2  
lamdaW - Used to calculate a portion of the proposed Vandermonde inverse. Specifically, the lambda in Theorem 2.2.  
node_sampling -Outputs sampled nodes for interpolation  
polyfit_custom- Polynomial fitting over a set of given nodes, using a selected vandermonde inverse and ESP solution.  






