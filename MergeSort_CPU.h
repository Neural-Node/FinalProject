#ifndef MERGESORT_CPU_H
#define MERGESORT_CPU_H

// Merges two subarrays of arr[].
// First subarray is arr[l..m]
// Second subarray is arr[m+1..r]
void merge(int* arr, int l, int m, int r);

// Main function to perform merge sort
void mergeSort_CPU(int* arr, int l, int r);

#endif  // MERGESORT_CPU_H
