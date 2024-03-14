# Target to compile the main program
main: main.c MergeSort_CPU.c MergeSort_GPU.cu MergeSort_CPU.h MergeSort_GPU.h
	gcc main.c MergeSort_CPU.c MergeSort_GPU.cu -o main

# Target to compile MergeSort_GPU.cu into an executable
MergeSort_GPU: MergeSort_GPU.cu 
	nvcc -arch=sm_86 -o MergeSort_GPU MergeSort_GPU.cu

# Clean up intermediate files and the final executables
clean:
	rm -f main MergeSort_GPU
