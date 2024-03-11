// MergeSort_CPU.c
#include "MergeSort_CPU.h"

// Implementation of mergeSort_CPU
void mergeSort_CPU(int arr[], int l, int r) {
	if (l < r) {
		// Same as (l+r)/2, but avoids
		// overflow for a large l and r
		int m = l + (r -l) / 2;
	
		// Sort first and second halves
		mergeSort_CPU(arr, l, m);
		mergeSort_CPU(arr, m + 1,r);

		merge(arr,l, m, r);
	}    
}
