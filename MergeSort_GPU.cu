#include <stdio.h>
#include <cuda_runtime.h>
#define THREADS_PER_BLOCK 256

__device__ void mergeGPU(int *arr, int *temp, int l, int m, int r) {
    int i = l + threadIdx.x;
    int j = m + 1 + threadIdx.x;
    int k = l + threadIdx.x;
    
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
    for (i = l + threadIdx.x; i <= r; i += blockDim.x)
        arr[i] = temp[i];
}

__global__ void mergeSort_GPU(int *arr, int *temp, int n) {
    int tid = threadIdx.x + blockIdx.x * blockDim.x;
    int l, r, m;
    
    // Merge sort algorithm
    for (int size = 1; size < n; size *= 2) {
        for (int start = 0; start < n - 1; start += 2 * size) {
            l = start;
            m = start + size - 1;
            r = min(start + 2 * size - 1, n - 1);
            mergeGPU(arr, temp, l, m, r);
        }
    }
}