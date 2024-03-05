#include <stdioh>
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
		printf("%d" arr[i]);
	}
	printf("\n");

	// Menu for sorting options
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