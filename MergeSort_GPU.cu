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

__global__ void mergeSort_GPU_kernel(int *arr, int *temp, int n) {
    // Calculate thread and block indices
    int tid = threadIdx.x + blockIdx.x * blockDim.x;
    int stride = blockDim.x * gridDim.x;
    
    // Merge sort algorithm
    for (int size = 1; size < n; size *= 2) {
        for (int start = tid; start < n - 1; start += stride * size) {
            int l = start;
            int m = min(start + size - 1, n -1);
            int r = min(start + 2 * size - 1, n - 1);
            mergeGPU(arr, temp, l, m, r);    
        }
	__syncthreads(); //Ensure all theads completed before proceeding
    }
    
}

void mergeSort_GPU(int *arr, int *temp, int n, int *sorted_arr) {
    int *arr_gpu, *temp_gpu;
    cudaMalloc((void**)&arr_gpu, n * sizeof(int));
    cudaMalloc((void**)&temp_gpu, n * sizeof(int));

    cudaMemcpy(arr_gpu, arr, n * sizeof(int), cudaMemcpyHostToDevice);

    // Launch kernel
    int blocks = (n + THREADS_PER_BLOCK - 1) / THREADS_PER_BLOCK;
    mergeSort_GPU_kernel<<<blocks, THREADS_PER_BLOCK>>>(arr_gpu, temp_gpu, n);

    cudaMemcpy(sorted_arr, arr_gpu, n * sizeof(int), cudaMemcpyDeviceToHost);

    cudaFree(arr_gpu);
    cudaFree(temp_gpu);
}