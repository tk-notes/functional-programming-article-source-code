const PI = 3.14;

/* Not pure: it uses the global constant */
const calculateArea = (radius) => radius * radius * PI;

/* Pure: it uses only parameters passed to the function */
const calculateArea = (radius, PI) => radius * radius * PI;


var counter = 1;

var increaseCounter = function() {
  counter++;
  return counter;
}

increaseCounter(); // 2
counter; // 2


var counter = 1;

var increaseCounter = function(counter) {
  return counter + 1;
}

increaseCounter(counter); // 2
counter; // 1
