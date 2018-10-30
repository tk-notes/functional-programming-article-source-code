# Functional Programming

This is my learning journey

![](https://cdn-images-1.medium.com/max/1600/1*OtbWm_2OFtg7suie4zEtqA.png)

*****

> **Functional programming** is a programming paradigm — a style of building the
> structure and elements of computer programs — that treats computation as the
evaluation of mathematical functions and avoids changing-state and mutable data
— [Wikipedia](https://en.wikipedia.org/wiki/Functional_programming)

*****

### Pure Functions

![](https://cdn-images-1.medium.com/max/1600/0*FMur6URY7yAVjeuP)
<span class="figcaption_hack">“water drop” by [Mohan
Murugesan](https://unsplash.com/@martinmohan?utm_source=medium&utm_medium=referral)
on [Unsplash](https://unsplash.com/?utm_source=medium&utm_medium=referral)</span>

The first fundamental concept we learn when we want to understand Functional
Programming is Pure functions. But what does that really mean? What does it make
a function pure?

So how do we know if a function is `pure` or not? Here is a very strict
definition of purity:

* It returns the same result if given the same arguments (it is also referred as
`deterministic`)
* It does not cause any observable side effects

*****

#### **It returns the same result if given the same arguments**

Imagine we want to implement a function that calculates the area of a circle. An
impure function would receive `radius` as the parameter, and then calculates
`radius * radius * PI`. In Clojure, the operator comes first, so `radius *
radius * PI` becomes `(* radius radius PI)`:

Why is this an impure function? Simply because it uses a global object that was
not passed as a parameter to the function.

Now imagine some mathematicians discover that the `PI` value is actually `42`.

Our impure function will now result in `10 * 10 * 42` = `4200`. For the same
parameter (`radius = 10`), we have a different result. Let's fix it!

TA-DA 🎉! Now we'll always pass `PI` value as a parameter to the function. So
now we are just accessing parameters passed to the function. No `external
object`.

* For the parameters `radius = 10` & `PI = 3.14`, we will always have the same the
result: `314.0`
* For the parameters `radius = 10` & `PI = 42`, we will always have the same the
result: `4200`

*****

#### **Reading Files**

If our function reads external files, it's not a pure function, because the
file’s contents can change.

#### **Random number generation**

Any function that relies on a random number generator cannot be pure.

*****

#### It does not cause any observable side effects: modifying a global object or a
parameter passed by reference

Now we want to implement a function to receive an integer value and return the
value increased by 1.

We have the `counter` value. Our impure function receives that value and
re-assign the counter with the value increased by 1.

**Observation**: mutability is discouraged in functional programming.

We are modifying the global object. But how would we make it `pure`? Just return
the value increased by 1. Simple as that.

See that our pure function `increase-counter` returns 2, but the `counter` value
is still the same. The function returns the incremented value without altering
the value of the variable.

*****

If we follow these two simple rules, it gets easier to understand our programs.
Now every function is isolated and unable to impact other parts of our system.

Pure functions are stable, consistent, and predictable. Given the same
parameters, pure functions will always return the same result. We don't need to
think of the same parameter with different results because it will never happen.

*****

#### Pure Functions Benefits

It's definitely easier to test. We don't need to mock anything. So we can unit
test pure functions with different contexts:

* Given a parameter `A` → expect the function to return value `B`
* Given a parameter `C` → expect the function to return value `D`

A simple example would be a function to receive a collection of numbers and
expect it to increment each element of this collection.

We receive the `numbers` collection and use `map` with `inc` function to
increment each number, and return a new list of incremented numbers.

For the `input` `[1 2 3 4 5]`, the expected `output` would be `[2 3 4 5 6]`.

*****

### Immutability

> *Unchanging over time or unable to be changed.*

<span class="figcaption_hack">“Change neon light signage” by [Ross
Findon](https://unsplash.com/@rossf?utm_source=medium&utm_medium=referral) on
[Unsplash](https://unsplash.com/?utm_source=medium&utm_medium=referral)</span>

When data is immutable, its** state cannot change*** ***after it’s created. **If
you want to change an immutable object, you can’t. Instead,** you create a new
object with the new value.**

In Javascript we commonly use the `for` loop. This next `for` statement has some
mutable variables.

For each iteration, we are changing the `i` and the `sumOfValue` **state**. But
how do we handle mutability in iteration? Recursion! Back to Clojure!

So here we have the `sum` function that receives a vector of numerical values.
The `recur` jumps back into the `loop` until we get the vector empty ([our
recursion
](https://en.wikipedia.org/wiki/Recursion_(computer_science)#Recursive_functions_and_algorithms)`base
case`). For each "iteration" we will add the value to the `total` accumulator.

With recursion, we keep our *"variables" *immutable.

**Obs**: Yes! We can use `reduce` to implement this function. We will see this
in the `Higher Order Functions` topic.

*****

It is also very common to build up the final **state** of an object. Imagine we
have a string, and we want to transform this string into a `url slug`.

In OOP in Ruby, we would create a class, let's say, `UrlSlugify`. And this class
will have a `slugify!` method to transform the string input into a `url slug`.

Beautiful! It's implemented! Here we have an imperative programming saying
exactly what we want to do in each `slugify` process: first lower case, then
remove useless white spaces, and finally replace white space with hyphen.

But we are mutating the input state in this process.

We can handle this mutation by doing function composition, or function chaining.
In other words, the result of a function will be used as an input for the next
function, without modifying the original input string.

Here we have:

* `trim`: removes whitespace from both ends of string
* `lower-case`: converts string to all lower-case
* `replace`: replaces all instance of match with replacement in a given string

We combine all 3 functions and we can `"slugify"` our string.

Speaking in *combining functions*, we can use the `comp` function to compose all
the 3 functions. Let's take a look:

*****

### Referential Transparency

<span class="figcaption_hack">“person holding eyeglasses” by [Josh
Calabrese](https://unsplash.com/@joshcala?utm_source=medium&utm_medium=referral)
on [Unsplash](https://unsplash.com/?utm_source=medium&utm_medium=referral)</span>

Let's implement a `square function`.

For this (pure) function, it will always have the same output, given the same
input.

Passing 2 as a parameter of the `square function`, it will always returns 4. So
now we can replace the `(square 2)` with 4. That's it! Our function is
`referentially transparent`.

Basically, if a function consistently yields the same result for the same input,
it is referentially transparent.

> **Pure Functions + Immutable Data = Referential Transparency**

With this concept, a cool thing we can do is to memoize the function. Imagine we
have this function:

The `(+ 5 8)` equals `13`. This function will always result in `13`. So we can
do this:

An this expression will always result in `16`. We can replace the entire
expression with a numerical constant and
[memoize](https://en.wikipedia.org/wiki/Memoization) it.

*****

### Functions as First-class entities

<span class="figcaption_hack">“first-class” by [Andrew
Neel](https://unsplash.com/@andrewtneel?utm_source=medium&utm_medium=referral)
on [Unsplash](https://unsplash.com/?utm_source=medium&utm_medium=referral)</span>

The idea of functions as first-class entities is that functions are also treated
as values and used as data.

In Clojure it's common to use `defn` to define functions, but, this is just
syntactic sugar for `(def foo (fn ...))`. `fn` returns the function itself.
`defn` returns a var which points to a function object.

Functions as first-class entities can:

* Refer to it from constants and variables
* Pass it as a parameter to other functions
* Return it as result from other functions

The idea to treat functions as values and pass functions like data. This way we
can combine functions with other functions to create new functions with new
behavior.

Imagine we have a function that sum two values and then double the value.
Something like this:

Now a function that subtracts values and the returns the double:

These functions have similar logic, but the difference is the operators
functions. If we can treat functions as values and pass it as arguments, we can
build a function that receives the operator function and use it inside our
function. Let's build it!

Done! Now we have an `f` argument, and use it to process `a` and `b`. We passed
the `+` and `-` functions to compose with the `double-operator` function and
create a new behavior.

*****

### Higher Order Functions

When we talk about higher order functions, we mean a function that either:

* Takes one or more functions as arguments
* Or returns a function as its result

The `double-operator` function we implemented above is a higher order function,
because it takes an operator function as an argument and use it.

Probably you've already heard about `filter`, `map`, and `reduce`. Let's take a
look at it.

#### Filter

Given a collection, we want to filter by an attribute. The filter function
expects a `true` or `false` value to determine if the element should or not be
included in the result collection. Basically, if the callback expression is
`true`, the filter function will include the element in the result collection.
Otherwise, it will not.

A simple example is when we have a collection of integers and we want only the
even numbers.

An imperative way to do it with Javascript is to…

* Create an empty vector `evenNumbers`
* Iterate over the `numbers` vector
* Push the even number to the `evenNumbers` vector

But we can use the `filter` higher order function to receive the `even?`
function, and returns a list of event numbers:

One interesting problem I solved on [Hacker Rank
FP](https://www.hackerrank.com/domains/fp) Path was the [Filter Array
problem](https://www.hackerrank.com/challenges/fp-filter-array/problem). The
problem idea is to filter a given array of integers and output only those values
that are less than a specified value `X`.

An imperative Javascript solution to this problem is something like that:

We say exactly what our function needs to do: iterate over the collection,
compare the collection current item with `x`, and push this element to the
`resultArray` if it pass the condition.

But we want a more declarative way to solve this problem, and using the `filter`
higher order function as well.

A declarative Clojure solution would be something like this:

This syntax seems a bit strange in the first place, but `#(> x %)` is just a
anonymous function that receives `x` and compare with each element in the
collection (`%` represents the parameter of the anonymous function — in this
case the current element inside the `filter`).

We can also do this with maps. Imagine we have a map of people with `name` and
`age`. And we want to filter only people over age, meaning people who are more
than 21 years old.

* We have a list of people (with `name` and `age`).
* We have the anonymous function `#(< 21 (:age %))`. Remember that the `%`
represents the current element from the collection? Well, the element of the
collection is a people map. If we do `(:age {:name "TK" :age 26})`, it returns
the age value, `26` in this case.
* We filter all people based on this anonymous function.

*****

#### Map

The idea of map is to transform a collection.

> The `map` method transforms a collection by applying a function to all of its
> elements and building a new collection from the returned values.

Let's get the same `people` collection above. We don't want to filter the by
over age now. We just want a list of strings, something like `TK is 26 years
old`. So the final string might be `:name is :age years old` where `:name` and
`:age` are attributes from each element from the `people` collection.

In a imperative Javascript way, it would be:

In a declarative Clojure way, it would be:

The whole idea is to transform a given collection into a new collection.

Another interesting Hacker Rank problem was the [update list
problem](https://www.hackerrank.com/challenges/fp-update-list/problem). We just
want to update the values of a give collection with their absolute values.

For this input `[1 2 3 -4 5]`, the output needs to be `[1 2 3 4 5]`. The
absolute value of `-4` is `4`.

A simple solution would be an in-place update for each collection value.

We use the `Math.abs` function to transform the value into its absolute value,
and do the in-place update.

This is not a functional way to implement this solution.

First, we learned about immutability. We know how immutability is important to
make our functions more consistent and predictable. The idea is to build a new
collection with all absolute values.

Second, why not use `map` here to "transform" all data?

My first idea was to build a `to-absolute` function to handle only one value.

If it is negative, we want to transform it in a positive value (the absolute
value). Otherwise, we don't need to transform it.

Now that we know how to do `absolute` for one value, we can use this function to
pass as an argument to the `map` function. Do you remember that a `higher order
function` can receive a function as an argument and use it? Yes, map can do it!

Wow. So beautiful! 😍

*****

#### Reduce

The idea of reduce is to receive a function and a collection, and returns a
value created by combining the items.

A common example people talk about is to get the total amount of an order.
Imagine you were at amazon.com, and add `Product 1`, `Product 2`, `Product 3`,
and `Product 4` to the shopping cart (order). Now we want to calculate the total
amount of the shopping cart.

In imperative way, we would iterate the order list and sum each product amount
to the total amount.

Using `reduce`, we can build a function to handle the `amount sum` and pass it
as an argument to the `reduce` function.

Here we have `shopping-cart`, the function `sum-amount` that receives the
current `total-amount` and the `current-product` object to `sum` them.

And the `get-total-amount` function `reduce` the `shopping-cart` by using the
`sum-amount` and starting from `0`.

Another way to get the total amount is to compose `map` and `reduce`. What do I
mean by that? We can use `map` to transform the `shopping-cart` into a
collection of `amount` values, and then just use the `reduce` function with `+`
function.

The `get-amount` receives the product object and returns only the `amount`
value. So what we have here is `[10 30 20 60]`. And then the `reduce` combine
all items by adding up. Beautiful!

*****

We took a look at how each higher order function works, but I want to show you
an example of how we can compose all three functions in a simple example.

Talking about `shopping cart`, imagine we have this list of products in our
order:

We want the total amount of all books in our shopping cart. Simple as that. The
algorithm?

* **Filter** by book type
* Transform the shopping cart into a collection of amount using **map**
* Combine all items by adding up with **reduce**

Done! 🎉

*****

### Resources

I organised some resources I read and studied. Just want to share some of them,
that I found really interesting. For more resources, I'm storing all in my
[Functional Programming Github
repository](https://github.com/LeandroTk/learning-functional-programming).

* [Ruby specific
resources](https://github.com/LeandroTk/learning-functional-programming/tree/master/ruby)
* [Javascript specific
resources](https://github.com/LeandroTk/learning-functional-programming/tree/master/javascript)
* [Clojure specific
resources](https://github.com/LeandroTk/learning-functional-programming/tree/master/clojure)

#### Intros

* [Learning FP in JS](https://www.youtube.com/watch?v=e-5obm1G_FY)
* [Intro do FP with
Python](https://codewords.recurse.com/issues/one/an-introduction-to-functional-programming)
* [Overview of FP](https://blog.codeship.com/overview-of-functional-programming)
* [A quick intro to functional
JS](https://hackernoon.com/a-quick-introduction-to-functional-javascript-7e6fe520e7fa)
* [What is
FP?](https://medium.com/javascript-scene/master-the-javascript-interview-what-is-functional-programming-7f218c68b3a0)
* [Functional Programming
Jargon](https://github.com/hemanth/functional-programming-jargon)

#### Pure Functions

* [What is a pure
function?](https://medium.com/javascript-scene/master-the-javascript-interview-what-is-a-pure-function-d1c076bec976)
* [Pure Functional Programming
1](https://www.fpcomplete.com/blog/2017/04/pure-functional-programming)
* [Pure Functional Programming
2](https://www.fpcomplete.com/blog/2017/05/pure-functional-programming-part-2)

#### Immutable Data

* [Immutable DS for functional
programming](https://www.youtube.com/watch?v=Wo0qiGPSV-s)
* [Why shared mutable state is the root of all
evil](http://henrikeichenhardt.blogspot.com/2013/06/why-shared-mutable-state-is-root-of-all.html)
* [Structural Sharing in Clojure: Part
1](http://hypirion.com/musings/understanding-persistent-vector-pt-1)
* [Structural Sharing in Clojure: Part
2](http://hypirion.com/musings/understanding-persistent-vector-pt-2)
* [Structural Sharing in Clojure: Part
3](http://hypirion.com/musings/understanding-persistent-vector-pt-3)
* [Structural Sharing in Clojure: Final
part](http://hypirion.com/musings/persistent-vector-performance-summarised)

#### Higher Order Functions

* [Eloquent JS: Higher Order
Functions](https://eloquentjavascript.net/05_higher_order.html)
* [Fun fun function
Filter](https://www.youtube.com/watch?v=BMUiFMZr7vk&t=0s&list=PL0zVEGEvSaeEd9hlmCXrk5yUyqUag-n84&index=2&ab_channel=FunFunFunction)
* [Fun fun function
Map](https://www.youtube.com/watch?v=bCqtb-Z5YGQ&index=2&list=PL0zVEGEvSaeEd9hlmCXrk5yUyqUag-n84&ab_channel=FunFunFunction)
* [Fun fun function Basic
Reduce](https://www.youtube.com/watch?v=Wl98eZpkp-c&list=PL0zVEGEvSaeEd9hlmCXrk5yUyqUag-n84&index=3&frags=wn&ab_channel=FunFunFunction)
* [Fun fun function Advanced
Reduce](https://www.youtube.com/watch?v=1DMolJ2FrNY&list=PL0zVEGEvSaeEd9hlmCXrk5yUyqUag-n84&index=4&ab_channel=FunFunFunction)
* [Clojure Higher Order
Functions](https://clojure.org/guides/higher_order_functions)
* [Purely Function Filter](https://purelyfunctional.tv/lesson/filter/)
* [Purely Functional Map](https://purelyfunctional.tv/lesson/map/)
* [Purely Functional Reduce](https://purelyfunctional.tv/lesson/reduce/)

#### Declarative Programming

* [Declarative Programming vs
Imperative](https://tylermcginnis.com/imperative-vs-declarative-programming/)

*****

### That's it!

Hey people, I hope you had fun reading this post, and I hope you learned a lot
here! This was my attempt to share what I'm learning.

[Here is the repository with all
codes](https://github.com/LeandroTk/functional-programming-article-source-code)
from this article.

Come learn with me, I'm sharing resources and my code in this [Learning
Functional Programming
repository](https://github.com/LeandroTk/learning-functional-programming).

I hope you saw something useful to you here. And see you next time! :)

My [Twitter](https://twitter.com/LeandroTk_) &
[Github](https://github.com/LeandroTk). ☺

TK.
