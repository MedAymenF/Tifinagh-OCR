# Script to convert a labels.txt file to a json file
# labels.txt format: <filename> <label>
# json format: {"<filename>": "<label>"}
# Usage: ./labels_txt_to_json.sh <labels.txt> <output.json>

# Check if the number of arguments is correct
if [ $# -ne 2 ]; then
    echo "Usage: ./labels_txt_to_json.sh <labels.txt> <output.json>"
    exit 1
fi

# Check if the labels.txt file exists
if [ ! -f $1 ]; then
    echo "File $1 does not exist"
    exit 1
fi

# Check if the output file already exists
if [ -f $2 ]; then
    echo "File $2 already exists"
    exit 1
fi

# Create the output file
touch $2

# Write the json file
echo "{" >> $2
while read line; do
    filename=$(echo $line | cut -d' ' -f1)
    # Labels can contain spaces, so we need to get the rest of the line
    label=$(echo $line | cut -d' ' -f2-)
    echo "    \"$filename\": \"$label\"," >> $2
done < $1

# Remove the last comma
sed -i '$ s/.$//' $2

echo "}" >> $2

echo "Done"

exit 0
