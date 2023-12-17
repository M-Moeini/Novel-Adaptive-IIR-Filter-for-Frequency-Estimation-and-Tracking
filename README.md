# Adaptive Harmonic IIR Notch Filter for Frequency Estimation and Tracking

This project implements an adaptive harmonic Infinite Impulse Response (IIR) notch filter for accurate frequency estimation and tracking within a harmonic frequency environment. The code replicates concepts from the paper '[**Novel Adaptive IIR Filter for Frequency Estimation and Tracking**](https://ieeexplore.ieee.org/abstract/document/5230818?casa_token=DxMDCnTBnXsAAAAA:7CzY9qnxx0hZpN2GDohJ8RIwSNdo1HdZTcJAVAbHwrXt3lDEC-vWlLXdHvxsNy85QNDFJ1wv5nT3)' by **Li Tan** and **Jean Jiang**.


## I. Summary

The primary goal of this project is to create an efficient and adaptable filter that accurately estimates and tracks frequencies in complex harmonic environments. The implemented filter, based on the concepts presented in the paper, provides robust signal processing capabilities.

## II. Implementation Details

### MATLAB Implementation

The MATLAB code provided offers a practical implementation of the adaptive harmonic IIR notch filter. It includes:

- Initialization with defined parameters such as sampling frequency, number of iterations, filter coefficients, and signal frequencies.
- Two stages: 
  1. Calculation of optimized filter coefficients.
  2. Application of the adaptive filter to the input signal for frequency estimation and tracking.

### How to Use

To run the MATLAB implementation:

1. Ensure MATLAB is installed on your system.
2. Copy the provided MATLAB code into a new or existing MATLAB script.
3. Run the script within the MATLAB environment.

## III. Code Structure

The code is structured into several sections:

- **Initialization:** Setting up necessary parameters and defining input signals.
- **Stages:** Divided into two stages for optimal filter coefficient calculation and application of the adaptive filter.
- **Functions:** Includes functions like `notchFilter`, `mseMaker`, `lmsCal`, and more, essential for filter operations.

## IV. Results

The code generates visualizations and figures showcasing:

![MSE-Plot](https://github.com/M-Moeini/Novel-Adaptive-IIR-Filter-for-Frequency-Estimation-and-Tracking/blob/master/Results/MSE-Plot.png)



![Notch-Output](https://github.com/M-Moeini/Novel-Adaptive-IIR-Filter-for-Frequency-Estimation-and-Tracking/blob/master/Results/Notch-Output.png)



![Notch-Output](https://github.com/M-Moeini/Novel-Adaptive-IIR-Filter-for-Frequency-Estimation-and-Tracking/blob/master/Results/Notch-Output.png)

## V. Acknowledgments

This implementation heavily relies on the concepts from the paper '[**Novel Adaptive IIR Filter for Frequency Estimation and Tracking**](https://ieeexplore.ieee.org/abstract/document/5230818?casa_token=DxMDCnTBnXsAAAAA:7CzY9qnxx0hZpN2GDohJ8RIwSNdo1HdZTcJAVAbHwrXt3lDEC-vWlLXdHvxsNy85QNDFJ1wv5nT3)' authored by **Li Tan** and **Jean Jiang**.

