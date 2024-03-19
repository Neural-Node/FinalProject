#ifndef MERGE_SORT_H
#define MERGE_SORT_H

void mergeGPU(int *arr, int *temp, int l, int m, int r);
__global__ void mergeSort_GPU(int *arr, int *temp, int n);

#endif // MERGE_SORT_H
