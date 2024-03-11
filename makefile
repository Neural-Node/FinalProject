NVCC = nvcc -arch=sm_86
CC = gcc
CFLAGS = -Wall -Wextra -std=c99

# List of source files
SOURCES = main.c MergeSort_CPU.c MergeSort_GPU.cu
# List of header files
HEADERS = MergeSort_CPU.h MergeSort_GPU.h
# List of object files to be generated from source files
OBJECTS = $(SOURCES:.c=.o)
CU_OBJECTS = $(SOURCES:.cu=.o)

# Default target
all: merge_sort

# Target to compile the main program
merge_sort: $(OBJECTS) $(CU_OBJECTS)
	$(NVCC) $(OBJECTS) $(CU_OBJECTS) -o merge_sort

# Target to compile main.c into an object file
main.o: main.c $(HEADERS)
	$(CC) $(CFLAGS) -c main.c -o main.o

# Target to compile each C source file into object files
%.o: %.c $(HEADERS)
	$(CC) $(CFLAGS) -c $< -o $@

# Target to compile each CUDA source file into object files
%.o: %.cu $(HEADERS)
	$(NVCC) -c $< -o $@

# Clean up intermediate files and the final executable
clean:
	rm -f $(OBJECTS) merge_sort