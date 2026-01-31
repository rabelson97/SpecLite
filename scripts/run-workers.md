# run-workers

Split an input list into N chunks and optionally run a command per chunk.

Inputs:
- input_list: file with one item per line
- workers: number of chunks/workers
- out_dir: output folder for chunks
- command: optional command template; use {chunk} placeholder

Command:
```bash
./tools/run-workers.sh <input_list> <workers> <out_dir> "<command>"
```
