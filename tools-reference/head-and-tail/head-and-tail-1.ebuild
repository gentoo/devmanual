# Header.

# bad: get the first five lines of input.txt with all 'foo'
# replaced with 'bar'
head -n 5 input.txt | sed -e 's/foo/bar/g' > output.txt

# good: use sed's address ranges and command groups to do
# the same thing with only one fork
sed -n -e '1,5{ s/foo/bar/g ; p }' input.txt > output.txt

# good: another way is with an extra command which exits
# on line 5
sed -n -e 's/foo/bar/gp ; 5q' input.txt > output.txt

# bad: set foo to the first line containing somestring
foo=$(sed -n -e '/somestring/p' input.txt | head -n 1 )

# good: use early exit to do the same thing in pure sed
foo=$(sed -n -e '/somestring/{ p ; q }' input.txt )

# bad: output the last line matching 'somestring'
sed -n -e '/somestring/p' input.txt | tail -n 1

# good: do this in pure sed using the hold space
sed -n -e '/somestring/h ; ${ x ; p }'
