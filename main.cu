#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <cuda_runtime.h>
#include "MergeSort_CPU.h"

// Define your GPU merge sort function here
void mergeSort_GPU(int *arr, int n, int *sorted_arr);

#define MAX_SIZE 1000000000000

int main() {
    int n;

    // Input size of the array
    printf("Enter the size of the array: ");
    scanf("%d", &n);

    if (n <= 0 || n > MAX_SIZE) {
        printf("Invalid size.\n");
        return 1;
    }

    int *arr_cpu = (int *)malloc(n * sizeof(int));
    int *arr_gpu = (int *)malloc(n * sizeof(int));
    int *sorted_arr_cpu = (int *)malloc(n * sizeof(int));
    int *sorted_arr_gpu = (int *)malloc(n * sizeof(int));

    // Generate random arrays
    srand(time(NULL));
    for (int i = 0; i < n; i++) {
        arr_cpu[i] = rand() % 100; // Generate random values between 0 and 99
        arr_gpu[i] = arr_cpu[i];
    }

    // CPU Merge Sort
    clock_t start_cpu, end_cpu;
    double cpu_time_used;

    start_cpu = clock();
    mergeSort_CPU(arr_cpu, 0, n - 1, sorted_arr_cpu);
    end_cpu = clock();
    cpu_time_used = ((double) (end_cpu - start_cpu)) / CLOCKS_PER_SEC;
    printf("\nSorted Array using CPU Merge Sort:\n");
    printf("Time elapsed for CPU Merge Sort: %f seconds\n", cpu_time_used);

    // GPU Merge Sort
    clock_t start_gpu, end_gpu;
    double gpu_time_used;

    start_gpu = clock();
    mergeSort_GPU(arr_gpu, n, sorted_arr_gpu);
    end_gpu = clock();
    gpu_time_used = ((double) (end_gpu - start_gpu)) / CLOCKS_PER_SEC;
    printf("\nSorted Array using GPU Merge Sort:\n");
    printf("Time elapsed for GPU Merge Sort: %f seconds\n", gpu_time_used);

    // Free dynamically allocated memory
    free(arr_cpu);
    free(arr_gpu);
    free(sorted_arr_cpu);
    free(sorted_arr_gpu);

    return 0;
}
