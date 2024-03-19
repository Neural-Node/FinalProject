__device__ void mergeGPU(int *arr, int *temp, int l, int m, int r, int n) {
    int tid = threadIdx.x + blockIdx.x * blockDim.x;
    int i = l + tid;
    int j = m + 1 + tid;
    int k = l + tid;

    while (i <= m && j <= r && k < n) {
        if (arr[i] <= arr[j])
            temp[k - l] = arr[i++];
        else
            temp[k - l] = arr[j++];
        k++;
    }

    while (i <= m && k < n)
        temp[k++ - l] = arr[i++];

    while (j <= r && k < n)
        temp[k++ - l] = arr[j++];

    __syncthreads();

    for (i = l + tid; i <= r && i < n; i += blockDim.x * gridDim.x)
        arr[i] = temp[i - l];
}

__global__ void mergeSort_GPU(int *arr, int *temp, int n) {
    int tid = threadIdx.x + blockIdx.x * blockDim.x;
    int l, r, m;

    for (int size = 1; size < n; size *= 2) {
        for (int start = 0; start < n - 1; start += 2 * size) {
            l = start;
            m = start + size - 1;
            r = min(start + 2 * size - 1, n - 1);
            mergeGPU(arr, temp, l, m, r, n);
        }
        __syncthreads();
    }
}
