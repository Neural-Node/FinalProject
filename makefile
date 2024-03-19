# Target to compile the main program
main: main.cu MergeSort_CPU.o MergeSort_GPU.o MergeSort_CPU.h MergeSort_GPU.h
	nvcc -arch=sm_86 main.cu MergeSort_CPU.o MergeSort_GPU.o -o main

# Target to compile MergeSort_CPU.c into an object file
MergeSort_CPU.o: MergeSort_CPU.cu
	nvcc -c -arch=sm_86 -o MergeSort_CPU.o MergeSort_CPU.cu

# Target to compile MergeSort_GPU.cu into an object file
MergeSort_GPU.o: MergeSort_GPU.cu MergeSort_GPU.h
	nvcc -c -arch=sm_86 -o MergeSort_GPU.o MergeSort_GPU.cu

# Clean up intermediate files and the final executables
clean:
	rm -f main MergeSort_CPU.o MergeSort_GPU.o
