# adaptive-line-enhancer

Adaptive line enhancer to cancel out noises with high SNR. The filter adjusts its weights adaptively to pass the desired input signal while reducing the noise portion of the signal with little to no filter roll-off up to the Nyquist rate. This package makea use of the LMS and RLS estimation algorithms, along with two LMS variants. 

The first LMS variant is a standard normalised LMS, and the second runs this algorithm in both the forward and reverse sequence to reduce the estimation errors.


The main function runs the enhancer and generates various plots and figures, including an animation of the filters as they evolve and adapt to the changes in the signal. The included audio file can be swapped out for any other.
