#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <cuda_runtime.h>
#include "MergeSort_CPU.h"
#include "MergeSort_GPU.h"

#define MAX_SIZE 1000

int main() {
    int n;

    // Input size of the array
    printf("Enter the size of the array: ");
    scanf("%d", &n);

    if (n <= 0 || n > MAX_SIZE) {
        printf("Invalid size.\n");
        return 1;
    }

    int *arr = (int *)malloc(n * sizeof(int));
    int *arr_copy = (int *)malloc(n * sizeof(int));
    int *sorted_arr = (int *)malloc(n * sizeof(int));

    // Generate random array
    srand(time(NULL));
    printf("\nOriginal Array:\n");
    for (int i = 0; i < n; i++) {
        arr[i] = rand() % 100; // Generate random values between 0 and 99
        arr_copy[i] = arr[i];  // Make a copy for GPU merge sort
        printf("%d ", arr[i]);
    }
    printf("\n");

    // Menu for sorting options
    int choice;
    printf("\nChoose sorting option: \n");
    printf("1. CPU Merge Sort\n");
    printf("2. GPU Merge Sort \n");
    printf("Enter your choice: ");
    scanf("%d", &choice);


    switch (choice) {
        case 1: {
	    // Timing CPU mergeSort
	    cudaEvent_t start, end;
	    cudaEventCreate(&start);
	    cudaEventCreate(&end);
            cudaEventRecord(start);

            mergeSort_CPU(arr, 0, n - 1,sorted_arr);

            cudaEventRecord(end);
            cudaEventSynchronize(end);
            float elapsed_time;
            cudaEventElapsedTime(&elapsed_time, start, end);
            printf("\nSorted Array using CPU Merge Sort:\n");
            for (int i = 0; i < n; i++) {
                printf("%d ", sorted_arr[i]); // Print the sorted array
            }
	    printf("\nTime elapsed %.6f ms\n", elapsed_time);
            cudaEventDestroy(start);
	    cudaEventDestroy(end);
            break;
        }
        case 2:
	    // Timing GPU mergeSort
            cudaEvent_t start, end;
            cudaEventCreate(&start);
	    cudaEventCreate(&end);
            cudaEventRecord(start);

            mergeSort_GPU(arr_copy,0, n, sorted_arr);

	    cudaEventRecord(end);
	    cudaEventSynchronize(end);
            float elapsed_time;
	    cudaEventElapsedTime(&elapsed_time, start, end);
            printf("\nSorted Array using GPU Merge Sort:\n");
            for (int i = 0; i < n; i++) {
                printf("%d ", sorted_arr[i]);
            }
	    printf("\nTime elapsed: %.6f ms\n", elapsed_time);
	    cudaEventDestroy(start);
	    cudaEventDestroy(end);
            break;

        default:
            printf("Invalid choice\n");
            break;
    }

    // Free dynamically allocated memory
    free(arr);
    free(arr_copy);
    free(sorted_arr);

    return 0;
}

