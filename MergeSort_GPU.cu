#include <stdio.h>
#include <cuda_runtime.h>
#define THREADS_PER_BLOCK 1024

__device__ void Merge(int* arr, int* temp, int left, int middle, int right) {
    int i = left;
    int j = middle;
    int k = left;

    while (i < middle && j < right) {
        if (arr[i] <= arr[j])
            temp[k++] = arr[i++];
        else
            temp[k++] = arr[j++];
    }

    while (i < middle)
        temp[k++] = arr[i++];
    while (j < right)
        temp[k++] = arr[j++];

    for (int x = left; x < right; x++)
        arr[x] = temp[x];
}

__global__ void MergeSortGPU(int* arr, int* temp, int n, int width) {
    int tid = threadIdx.x + blockDim.x * blockIdx.x;
    int left = tid * width;
    int middle = left + width / 2;
    int right = left + width;

    if (left < n && middle < n) {
        Merge(arr, temp, left, middle, right);
    }
}

void mergeSort_GPU(int *arr, int n, int *sorted_arr) {
    int *arr_gpu, *temp_gpu;
    cudaMalloc((void**)&arr_gpu, n * sizeof(int));
    cudaMalloc((void**)&temp_gpu, n * sizeof(int));

    cudaMemcpy(arr_gpu, arr, n * sizeof(int), cudaMemcpyHostToDevice);

    int blocks = (n + THREADS_PER_BLOCK - 1) / THREADS_PER_BLOCK;
    int width = 2; // initial width for merging
    
    while (width < n) {
        MergeSortGPU<<<blocks, THREADS_PER_BLOCK>>>(arr_gpu, temp_gpu, n, width);
        width *= 2; // double the width for next iteration
    }

    cudaMemcpy(sorted_arr, arr_gpu, n * sizeof(int), cudaMemcpyDeviceToHost);

    cudaFree(arr_gpu);
    cudaFree(temp_gpu);
}