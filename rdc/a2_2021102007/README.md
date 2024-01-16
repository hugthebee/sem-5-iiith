
# Assignment 2

- Follow the directory structure to place the py files and PDFs
- Place your output image/video in `results` and Answer PDF in `docs`
```
.
├── A2.pdf
├── docs
├── README.md
├── results
├── setup.py
├── src
│   ├── q1
│   │   ├── answer.py
│   │   └── main.py
│   ├── q2
│   │   ├── answer.py
│   │   ├── demo.py
│   │   ├── main.py
│   │   └── sim.py
│   ├── q3
│   │   ├── answer.py
│   │   └── main.py
│   └── q4
│       ├── answer.py
│       └── main.py
└── util
    ├── __init__.py
    └── simulator.py

```

- For each question, a separate `main.py` is given to test your code

- Refrain from modifying the definitions of class methods in `answer.py` since we will run the testcases for evaluation. However, you can add your own class methods.

## Setup

- Install `numpy`, `matplotlib`, `pygame` in a conda environment
- Next, from the root location, Build using following command
    ```
    pip install -e .
    ```

### Note for Q3
- For Q3, an optional FK simulator along with demo code of 1R Manipulator has been provided in `demo.py`. **Bonus of 5 marks** will be awarded if you implement it for 3R-Manipulator. 

- Run the demo code to check the installation
    ```
    cd src/q2/
    
    python demo.py
    ```