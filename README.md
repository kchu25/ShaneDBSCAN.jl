# ShaneDBSCAN

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://kchu25.github.io/ShaneDBSCAN.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://kchu25.github.io/ShaneDBSCAN.jl/dev/)
[![Build Status](https://github.com/kchu25/ShaneDBSCAN.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/kchu25/ShaneDBSCAN.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/kchu25/ShaneDBSCAN.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/kchu25/ShaneDBSCAN.jl)



# Usage

Prepare a `n x p` matrix DB and execute the following:
```
using ShaneDBSCAN

labels = DBSCAN(DB, ;distFunc=euc_dist, eps=10, minPts=3)
```
The labels $\in \{-1,0,1,2,3,4,...\}$ are cluster indices. Specifically, 
* `0` means unclassified,
* `-1` means noise
* `1, 2, 3, ...` means cluster number `1,2,3,...`