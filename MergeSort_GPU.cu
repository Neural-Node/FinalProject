#include "MergeSort_GPU.h"
#include <stdio.h>

#define THREADS_PER_BLOCK 256

__global__ void merge(int *arr, int *temp, int l, int m, int r) {
    int i = l + blockIdx.x * blockDim.x + threadIdx.x;
    int j = m + 1 + blockIdx.x * blockDim.x + threadIdx.x;
    int k = l + blockIdx.x * blockDim.x + threadIdx.x;
    
    // Merge the two sorted arrays into temp array
    while (i <= m && j <= r) {
        if (arr[i] <= arr[j])
            temp[k++] = arr[i++];
        else
            temp[k++] = arr[j++];
    }
    
    // Copy the remaining elements of left array, if any
    while (i <= m)
        temp[k++] = arr[i++];
    
    // Copy the remaining elements of right array, if any
    while (j <= r)
        temp[k++] = arr[j++];
    
    // Copy the merged portion back to the original array
    for (i = l + blockIdx.x * blockDim.x + threadIdx.x; i <= r; i += blockDim.x * gridDim.x)
        arr[i] = temp[i];
}

__global__ void mergeSort(int *arr, int *temp, int l, int r) {
    if (l < r) {
        int m = l + (r - l) / 2;
        
        // Recursively sort the two halves
        mergeSort<<<(r - l + 1) / THREADS_PER_BLOCK + 1, THREADS_PER_BLOCK>>>(arr, temp, l, m);
        mergeSort<<<(r - l + 1) / THREADS_PER_BLOCK + 1, THREADS_PER_BLOCK>>>(arr, temp, m + 1, r);
        
        // Merge the sorted halves
        merge<<<1, THREADS_PER_BLOCK>>>(arr, temp, l, m, r);
    }

}
