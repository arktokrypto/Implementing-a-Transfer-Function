# Implementing-a-Transfer-Function
The continuous time transfer functions, whether it be a controller, filter, or a compensator, has to be converted to an implementable form to use in a microcontroller. This matlab code helps to convert the second order transfer function to discrete transfer function(z-domain) and then to a difference equation form.

## c2d
To convert an s-domain transfer function to an equivalent difference equation, you can use the c2d function in Matlab. This function converts a continuous-time system model to a discrete-time system model using a specified sample time.

This code defines a transfer function G in the s-domain and converts it to a discrete-time system using a sample time of 0.01 seconds and bilionear (tustin) method. It then extracts the numerator and denominator coefficients of the resulting discrete-time transfer function and prints the equivalent difference equation.
