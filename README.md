## Example

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