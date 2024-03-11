#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "MergeSort_CPU.h"
#include "MergeSort_GPU.h"


//Final Project MergeSort
// Team members: Jesse Javana, Trevor Felchlin
//Function prototypes
void merge(int arr[], int l, int m, int r);
void mergeSort_CPU(int arr[], int l, int r);
void mergeSort_GPU(int arr[], int l, int r);

int main() {
	// n will be size of the array
	int n;

	// Input size of the array
	printf("Enter the size of the array: ");
	scanf("%d", &n);

	int arr[n], arr_copy[n];

	// Generate random array
	printf("\nOriginal Array:\n");
	for (int i = 0; i < n; i++) {
		printf("%d", arr[i]);
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
        mergeSort_CPU(arr, 0, n - 1);
        printf("\nSorted Array using CPU Merge Sort:\n");
        for (int i = 0; i < n; i++) {
            printf("%d ", arr[i]);
        }
        break;

    case 2:
        mergeSort_GPU(arr_copy, 0, n - 1);
        printf("\nSorted Array using GPU Merge Sort:\n");
        for (int i = 0; i < n; i++) {
            printf("%d ", arr_copy[i]);
        }
        break;

    default:
        printf("Invalid choice\n");
        break;
    }

    return 0;

}

//Function to merge two subarrays of arr[]
void merge(int arr[], int l, int m, int r) {
	int i, j, k;
	int n1 =  m - l +1;
	int n2 = r - m;
	
	//Create temp arrays
	int L[n1], R[n2];

	// Copy data to temp arrays
	// L[] and R[]
	for (i = 0; i < n1; i++)
		L[i] = arr[l + i];
	for (j = 0 ; j < n2; j ++)
		R[j] = arr[m + l + j];
	
	// Merge the temp array back
	// into arr[l..r]
	// Initial index of first subarray
	i = 0;

	// Initial index of second subarray
	j = 0;

	// Initial index of merged subarray
	k = l;
	while (i < n1 && j < n2) {
		if (L[i] <= R[j]) {
			arr[k] = L[i];
			i++;
	}
	else {
		arr[k] = R[j];
		j++;
	}
	k++;
	}
	
	// Copy the remaining elements
	// of L[], if there are any
	while (i < n1) {
		arr[k] = L[i];
		i ++;
		k++;
	}
	
	// Copy the remaining elements of
	// of R[], if there are any
	while (j < n2) {
		arr[k] = R[j];
		j++;
		k++;
	}
}