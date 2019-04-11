# push, pop, unshift, and shift

[Video](https://player.vimeo.com/video/182440643?rel=0&amp;autoplay=1)

Four crucial array methods allow one to add and remove elements from the front or back of an array. `push` adds an element to the end of an array, while `pop` removes an element from the end of the array. `push` takes an argument (the element to be added) and returns the modified array. `pop` takes no argument and returns the element removed. Both methods modify the original array.
```
potpourri = [false, "Snuffles", nil, :rick, 3]
potpourri.push([]) #=> [false, "Snuffles", nil, :rick, 3, []]
potpourri #=> [false, "Snuffles", nil, :rick, 3, []] (push modified potpourri)
tail = potpourri.pop #=> []
potpourri #=> [false, "Snuffles", nil, :rick, 3] (pop modified potpourri)
tail #=> []
```
The shovel operator (`<<`) is functionally equivalent to `push`, but it allows for the simpler syntax typical of operators:
```
potpourri = [false, "Snuffles", nil, :rick, 3]
potpourri << ["Jerry", :krombopulos_michael] #=> [false, "Snuffles", nil, :rick, 3, ["Jerry", :krombopulos_michael]]
```
The analogues of `push` and `pop` for the front of the array rather than the end are `unshift` and `shift`. Both modify the original array.
```
potpourri = [false, "Snuffles", nil, :rick, 3]
potpourri.unshift([]) #=> [[], false, "Snuffles", nil, :rick, 3]
potpourri #=> [[], false, "Snuffles", nil, :rick, 3] (unshift modifies potpourri)
potpourri.shift #=> []
potpourri #=> [false, "Snuffles", nil, :rick, 3] (shift modified potpourri)
```