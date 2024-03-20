#include "MergeSort_CPU.h"
#include <stdlib.h> // For dynamic memory allocation

// Implementation of mergeSort_CPU
void mergeSort_CPU(int arr[], int l, int r, int sorted_array[]) {
    if (l < r) {
        int m = l + (r - l) / 2;

        // Sort first and second halves
        mergeSort_CPU(arr, l, m, sorted_array);
        mergeSort_CPU(arr, m + 1, r, sorted_array);

        // Merge the sorted halves
        merge(arr, l, m, r, sorted_array);
    }
}

// Function to merge two subarrays of arr[]
void merge(int arr[], int l, int m, int r, int sorted_array[]) {
    int i, j, k;
    int n1 = m - l + 1;
    int n2 = r - m;

    // Create temp arrays
    int *L = (int *)malloc(n1 * sizeof(int));
    int *R = (int *)malloc(n2 * sizeof(int));

    // Copy data to temp arrays L[] and R[]
    for (i = 0; i < n1; i++)
        L[i] = arr[l + i];
    for (j = 0; j < n2; j++)
        R[j] = arr[m + 1 + j];

    // Merge the temp arrays back into arr[l..r]
    i = 0; // Initial index of first subarray
    j = 0; // Initial index of second subarray
    k = l; // Initial index of merged subarray

    while (i < n1 && j < n2) {
        if (L[i] <= R[j]) {
            arr[k] = L[i];
            i++;
        } else {
            arr[k] = R[j];
            j++;
        }
        k++;
    }

    // Copy the remaining elements of L[], if any
    while (i < n1) {
        arr[k] = L[i];
        i++;
        k++;
    }

    // Copy the remaining elements of R[], if any
    while (j < n2) {
        arr[k] = R[j];
        j++;
        k++;
    }

    // Copy the sorted result to sorted_array
    for (i = l; i <= r; i++) {
        sorted_array[i] = arr[i];
    }

    // Free dynamically allocated memory
    free(L);
    free(R);
}
