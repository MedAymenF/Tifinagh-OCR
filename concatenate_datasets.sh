# Script to concatenate two datasets in the Doctr library format
# Usage ./concatenate_datasets.sh <dataset-1-dir> <dataset-2-dir> <output-dir>
: '
Doctr format:

├── images
    ├── img_1.png
    ├── img_2.png
    ├── img_3.png
    └── ...
├── labels.json
'

: '
labels.json format:

{
    "img_1.png": "ⴰ",
    "img_2.png": "ⴱ",
    "img_3.png": "ⴳ",
    "img_4.png": "ⴷ",
    "img_5.png": "ⴽⵯ",
    ...
}
'

# Check if the number of arguments is correct
if [ $# -ne 3 ]; then
    echo "Usage: ./concatenate_datasets.sh <dataset-1-dir> <dataset-2-dir> <output-dir>"
    exit 1
fi

# Check if the dataset-1 directory exists
if [ ! -d $1 ]; then
    echo "Directory $1 does not exist"
    exit 1
fi

# Check if the dataset-2 directory exists
if [ ! -d $2 ]; then
    echo "Directory $2 does not exist"
    exit 1
fi

# Check if the output directory already exists
if [ -d $3 ]; then
    echo "Directory $3 already exists"
    exit 1
fi

# Create the output directory
mkdir -p $3/images

# Copy the images from dataset-1 to the output directory
# cp $1/images/* $3/images # Argument list too long error
find $1/images -type f -exec cp {} $3/images \;

# Copy the images from dataset-2 to the output directory
# cp $2/images/* $3/images # Argument list too long error
find $2/images -type f -exec cp {} $3/images \;

# Concatenate the labels.json files using jq (assuming no filename collisions)
jq -s '.[0] * .[1]' $1/labels.json $2/labels.json > $3/labels.json

echo "Done"

exit 0
