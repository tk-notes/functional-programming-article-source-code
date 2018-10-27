const PI = 3.14;

/* Not pure: it uses the global constant */
const calculateArea = (radius) => radius * radius * PI;

/* Pure: it uses only parameters passed to the function */
const calculateArea = (radius, PI) => radius * radius * PI;
