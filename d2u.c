#define _GNU_SOURCE

#include <stdbool.h>
#include <stdio.h>
#include <string.h>

#include "has-cr.h"

int main() {
    FILE *fp;
    // Open file descriptor 0, i.e. stdin
    fp = fdopen(0, "r");

    // Iterate over lines
    char *line = NULL;
    size_t len = 0;
    while (getline(&line, &len, fp) != -1) {
        bool found = has_cr(line, strlen(line));
        if (found) {
            // Manipulate string to replace /r/n with /n. We're
            // assuming /r/n is at the end of the line, and that this
            // is the only occurrence of /r.
            line[strlen(line) - 1] = '\0';
            line[strlen(line) - 1] = '\n';
        }
        printf("%s", line);
    }
}
