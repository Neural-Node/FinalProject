#include <stdio.h>
#include <stdlib.h>
#include <time.h>
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
        case 1:
            //mergeSort_CPU(arr, 0, n - 1);
            printf("\nSorted Array using CPU Merge Sort:\n");
            for (int i = 0; i < n; i++) {
                printf("%d ", arr[i]);
            }
            break;

        case 2:
            mergeSort_GPU(arr_copy,0, n);
            printf("\nSorted Array using GPU Merge Sort:\n");
            for (int i = 0; i < n; i++) {
                printf("%d ", arr_copy[i]);
            }
            break;

        default:
            printf("Invalid choice\n");
            break;
    }

    // Free dynamically allocated memory
    free(arr);
    free(arr_copy);

    return 0;
}
