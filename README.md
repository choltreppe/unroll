## Example

### unroll

```nim
for i, v in unroll([2, 3, 4]):
  echo i, ": ", v
```

gets expanded to:
```nim
block:
  echo 0, ": ", 2
block:
  echo 1, ": ", 3
block:
  echo 2, ": ", 4
```

### unrollMapSeq

unroll directly into a `seq`

```nim
let arr =
  for v in unrollMapSeq([4, 5, 6]):
    v + 2
```

gets expanded into:
```nim
let arr = @[
  (4 + 2),
  (5 + 2),
  (6 + 2)
]
```

works with any type of loop:
```nim
const arr2 =
  for v in unrollMapSeq('a' .. 'c'):
    v & "1"
```

### unrollMapArray

works exactly like `unrollMapSeq` but produces an array