#!/bin/bash
# Critical Log Analysis Script
# This script analyses log files for critical errors and finds the most frequent words
# Variables
LOG_FILE="sys_log.txt"
OUTPUT_FILE="top10_critical.txt"
echo "=== Critical Log Analysis Script ==="
echo "Analyzing log file: $LOG_FILE"
echo ""
# Check if log file exists
if [ ! -f "$LOG_FILE" ]; then
echo "ERROR: Log file ‘$LOG_FILE’ not found!"
echo "Please make sure the log file exists in the current directory."
exit 1
fi
echo "Step 1: Filtering critical logs using keywords…"
# 1. Filter critical logs using keywords (case-insensitive)
# Search for ERROR, CRITICAL, FATAL keywords
grep -i -E "(ERROR|CRITICAL|FATAL)" "$LOG_FILE" > filtered_logs.txt
# Check if any critical logs were found
if [ ! -s filtered_logs.txt ]; then
echo "No critical logs found containing ERROR, CRITICAL, or FATAL keywords."
exit 1
fi
echo "Found $(wc -l < filtered_logs.txt) critical log lines"
echo ""
echo "Step 2: Tokenizing filtered logs into individual words…"
# 2. Tokenize filtered logs into individual words
# Convert to lowercase, replace punctuation with spaces, split into words
cat filtered_logs.txt |
tr '[:upper:]' '[:lower:]' |
tr -s '[:punct:][:space:]' '\n' |
sed '/^$/d' > tokens.txt
echo "Created $(wc -l < tokens.txt) tokens from critical logs"
echo ""
echo "Step 3: Counting frequency and sorting word frequencies…"
# 3. Count frequency and sort word frequencies
# Sort tokens, count frequencies, sort by frequency (descending), get top 10
sort tokens.txt |  
uniq -c |  
sort -nr |  
head -10 > "$OUTPUT_FILE"
echo "Top 10 most frequent tokens in critical logs:"
echo "============================================="
cat "$OUTPUT_FILE"
echo ""
echo "Step 4: Results saved to $OUTPUT_FILE"
echo ""
# Display some statistics
echo "=== Analysis Summary ==="
echo "Total critical log lines: $(wc -l < filtered_logs.txt)"
echo "Total tokens analyzed: $(wc -l < tokens.txt)"
echo "Unique tokens found: $(sort tokens.txt | uniq | wc -l)"
echo "Results saved to: $OUTPUT_FILE"
# Clean up temporary files
rm -f filtered_logs.txt tokens.txt
echo ""
echo "Analysis complete! Check $OUTPUT_FILE for the top 10 most frequent critical tokens."
