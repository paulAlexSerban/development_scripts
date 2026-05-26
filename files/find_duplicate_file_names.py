#!/usr/bin/env python3
import os
import sys
import argparse
from collections import defaultdict

def find_duplicate_names(target_directory, min_size_mb):
    # Convert MB to bytes
    min_size_bytes = min_size_mb * 1024 * 1024
    files_by_name = defaultdict(list)
    
    print(f"Scanning '{target_directory}' for files ≥ {min_size_mb} MB...\n")
    
    for root, _, filenames in os.walk(target_directory):
        for filename in filenames:
            full_path = os.path.join(root, filename)
            try:
                file_size = os.path.getsize(full_path)
                if file_size >= min_size_bytes:
                    files_by_name[filename].append(full_path)
            except (OSError, PermissionError):
                continue

    duplicate_count = 0
    for filename, paths in files_by_name.items():
        if len(paths) > 1:
            duplicate_count += 1
            # Calculate size from the first path instance
            size_mb = os.path.getsize(paths[0]) / (1024 * 1024)
            print(f"Duplicate Name: {filename} ({size_mb:.2f} MB)")
            for path in paths:
                print(f"  -> {path}")
            print("-" * 50)
            
    if duplicate_count == 0:
        print("No duplicate filenames found matching those criteria.")
    else:
        print(f"Scan complete. Found {duplicate_count} duplicate file groups.")

def main():
    parser = argparse.ArgumentParser(
        description="Find duplicate files by name over a specific size threshold."
    )
    
    # Position argument: Directory to scan (defaults to current directory if left out)
    parser.add_argument(
        "directory", 
        nargs="?", 
        default=".", 
        help="The directory path to scan (default: current directory '.')"
    )
    
    # Optional argument: Size threshold
    parser.add_argument(
        "-s", "--size", 
        type=float, 
        default=50.0, 
        help="Minimum file size in MB to consider (default: 50.0 MB)"
    )

    args = parser.parse_args()

    # Validate that the path actually exists
    if not os.path.exists(args.directory):
        print(f"Error: The directory '{args.directory}' does not exist.", file=sys.stderr)
        sys.exit(1)
        
    if not os.path.isdir(args.directory):
        print(f"Error: '{args.directory}' is a file, not a directory.", file=sys.stderr)
        sys.exit(1)

    find_duplicate_names(args.directory, args.size)

if __name__ == "__main__":
    main()