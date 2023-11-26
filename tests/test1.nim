# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest
import unroll

test "can unroll":
  for i, (a, b) in unroll([(0.4, 'a'), (0.6, 'b')]):
    echo i, ": (", a, ", ", b, ")"

  type Test = enum tA, tB
  for x in unroll(Test):
    echo x

  for a in [1, 2, 3]:
    for b in unroll([4, 5, 6]):
      echo a, " ", b

  for a in unroll([1, 2, 3]):
    for b in [4, 5, 6]:
      echo a, " ", b

  for a in unroll([1, 2, 3]):
    for b in unroll([4, 5, 6]):
      echo a, " ", b

test "can unrollMapArray":
  let arr1 =
    for v in unrollMapArray([4, 5, 6]):
      v + 2

  check arr1 == [6, 7, 8]

  const arr2 =
    for v in unrollMapArray('a' .. 'c'):
      v & "1"

  check arr2 == ["a1", "b1", "c1"]

test "can unrollMapSeq":
  let arr1 =
    for v in unrollMapSeq([4, 5, 6]):
      v + 2

  check arr1 == @[6, 7, 8]