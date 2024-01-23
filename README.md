# **Push_Swap Visualizer**
## Introduction
push swap visualizer is a tool designed to help users understand and optimize the sorting algorithm of the **push_swap** 42 School Project.

I wanted to create visual tester for my Push_swap project and i wanted to make it easy to run and install for everyone! So i made python script take input from 
the output of push_swap program (pa, pb, sa, sb, ss, ra, rb, rr, rra, rrb and rrr). Script then takes those operations and displays them between 2 stacks.

This visualizer aids in observing the behavior of the algorithm in real-time, enabling a better understanding and debugging of the sorting process.


![Screenshot of visualizer in action](https://github.com/Vallehtelia/PushSwap-Visualizer-Test/assets/141771396/d1e0e2e3-588c-4ddf-9a7f-78d9bd8997cb)

## Features
-**Few tests to check if basic arguments are working.**

-**Norminette check.**

-**Real-time visualization of the sorting process.**

-**Step-by-step execution to observe each operation.**

-**Adjustable speeds for visualization.**

-**Color-coded elements for better distinction.**

<img width="334" alt="Screen Shot 2024-01-24 at 0 50 26" src="https://github.com/Vallehtelia/PushSwap-Visualizer-Test/assets/141771396/5c60bca5-06e3-4511-9586-b3856729bf8a">

## Installation
Ensure you have Python installed on your system. This project is built with Python 3.x.

Clone the repository to where `your push_swap` files are:
```
git clone https://github.com/Vallehtelia/PushSwap-Visualizer-Test
```
Move files from `PushSwap-Visualizer-Test` to yours with following command:
```
`mv PushSwap-Visualizer-Test/push_swap_visualizer.py PushSwap-Visualizer-Test/visualize_push_swap.sh PushSwap-Visualizer-Test/images .`
```
## Install the required packages:

### Python 3
The project is developed using Python 3. Ensure that Python 3 is installed on your system. 
You can download it from the [Offical python website](https://www.python.org/downloads/).

### Pygame
This project uses Pygame for visualization. Once Python is installed, you can install Pygame using pip (Python's package installer). 
Run the following command in your terminal:
```
pip3 install pygame
```
## Usage
To run the visualizer, execute the following command in the terminal:
```
bash visualize_push_swap.sh
```
## Contributing
Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are greatly appreciated.

###Fork the Project
Create your Feature Branch (git checkout -b feature/AmazingFeature)
Commit your Changes (git commit -m 'Add some AmazingFeature')
Push to the Branch (git push origin feature/AmazingFeature)
Open a Pull Request
