CC = gcc
NVCC = nvcc
CFLAGS = -Wall -Wextra -Werror
LDFLAGS = -lcudart

SRCDIR = .
OBJDIR = obj
BINDIR = bin

SRC_FILES = $(wildcard $(SRCDIR)/*.c) $(wildcard $(SRCDIR)/*.cu)
OBJ_FILES = $(patsubst $(SRCDIR)/%.c, $(OBJDIR)/%.o, $(filter %.c, $(SRC_FILES))) \
            $(patsubst $(SRCDIR)/%.cu, $(OBJDIR)/%.o, $(filter %.cu, $(SRC_FILES)))
EXECUTABLE = $(BINDIR)/main

.PHONY: all clean

all: $(EXECUTABLE)

$(EXECUTABLE): $(OBJDIR)/Main.o $(OBJDIR)/MergeSort_CPU.o $(OBJDIR)/MergeSort_GPU.o
	$(NVCC) $(LDFLAGS) -o $@ $^ -lcudart

$(OBJDIR)/%.o: $(SRCDIR)/%.c
	$(CC) $(CFLAGS) -c -o $@ $<

$(OBJDIR)/%.o: $(SRCDIR)/%.cu
	$(NVCC) -c $< -o $@  # Remove -Werror

clean:
	rm -rf $(OBJDIR) $(BINDIR)

$(shell mkdir -p $(OBJDIR) $(BINDIR))
