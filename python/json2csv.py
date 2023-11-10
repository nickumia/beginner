
import json
import csv


# Read json file
with open("csv.json", "r") as t:
    a = json.load(t)

# Extract keys as column fields
field = [k for k,v in a[0].items()]

# Write to CSV
with open('profiles1.csv', 'w', newline='') as f:
    writer = csv.writer(f)

    # Write headers
    writer.writerow(field)
    for row in a:
        # Write rows
        writer.writerow([v for k,v in row.items()])

