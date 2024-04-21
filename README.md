# Asynchronous GCD Calculator - UVM Environment

## Introduction

This repository contains a Universal Verification Methodology (UVM) environment designed to verify an Asynchronous GCD (Greatest Common Divisor) calculator.

## Getting Started 
1. `git clone git@github.com:NathanNator/LearningHub.git`
2. Set up your simulation environment using ModelSim
3. Navigate to the sim directory where the Makefile is located:
   ```bash
   cd sim
   ```
4. Run the desired Makefile targets (see targets below for details)

## Makefile Targets

### `clean` 

The clean target removes all unnecessary or generated files 

```bash
make clean
```

### `sim_c`

Simulate the Asynchronous GCD env by running the with `+UVM_TESTNAME=gcd_test` in batchmode. 

```bash
make sim_c
```

### `sim`

Simulate the Asynchronous GCD env by running the with `+UVM_TESTNAME=gcd_test` with the MODELSIM Gui.

```bash
make sim
```


