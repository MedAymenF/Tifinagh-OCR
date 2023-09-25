# Script to convert the Tifinagh-MNIST repo dataset to the Doctr library format
# Usage: ./convert_tifinagh_mnist_to_doctr_format.sh <tifinagh-mnist-repo-dir> <train-dir> <test-dir>
: '
Tifinagh-MNIST format:

├── Tifinagh-MNIST
    ├── Dataset
        ├── test_data
            ├── 0
                ├── <filename>.png
                ├── ...
            ├── 1
            ├── 2
            └── ...
            ├── 32
        ├── train_data
            ├── 0
            ├── 1
            ├── 2
            └── ...
            ├── 32
    └── ...
'

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
    echo "Usage: ./convert_tifinagh_mnist_to_doctr_format.sh <tifinagh-mnist-repo-dir> <train-dir> <test-dir>"
    exit 1
fi

# Check if the Tifinagh-MNIST repo directory exists
if [ ! -d $1 ]; then
    echo "Directory $1 does not exist"
    exit 1
fi

# Check if the train directory already exists
if [ -d $2 ]; then
    echo "Directory $2 already exists"
    exit 1
fi

# Check if the test directory already exists
if [ -d $3 ]; then
    echo "Directory $3 already exists"
    exit 1
fi

# Make sure the filenames are unique by adding a class number suffix
# to the filename
for i in {0..32}; do
    for file in $1/Dataset/train_data/$i/*.png; do
        filename=$(basename $file)
        # Remove the .png extension
        filename="${filename%.*}"
        mv $file $1/Dataset/train_data/$i/$filename-$i.png
    done
done

for i in {0..32}; do
    for file in $1/Dataset/test_data/$i/*.png; do
        filename=$(basename $file)
        # Remove the .png extension
        filename="${filename%.*}"
        mv $file $1/Dataset/test_data/$i/$filename-$i.png
    done
done

# Create the train and test directories
mkdir -p $2/images
mkdir -p $3/images

# Create the labels.json files
touch $2/labels.json
touch $3/labels.json

# Write the labels.json files
echo "{" >> $2/labels.json
echo "{" >> $3/labels.json

# Write the labels.json files and map the labels to the Tifinagh script
for i in {0..32}; do
    # Map the labels to the Tifinagh script
    case $i in
        0) label="ⴰ";;
        1) label="ⴱ";;
        2) label="ⵛ";;
        3) label="ⴷ";;
        4) label="ⴻ";;
        5) label="ⴼ";;
        6) label="ⴳ";;
        7) label="ⵀ";;
        8) label="ⵉ";;
        9) label="ⵊ";;
        10) label="ⴽ";;
        11) label="ⵍ";;
        12) label="ⵎ";;
        13) label="ⵏ";;
        14) label="ⵇ";;
        15) label="ⵔ";;
        16) label="ⵙ";;
        17) label="ⵜ";;
        18) label="ⵓ";;
        19) label="ⵡ";;
        20) label="ⵅ";;
        21) label="ⵢ";;
        22) label="ⵣ";;
        23) label="ⵃ";;
        24) label="ⵚ";;
        25) label="ⴹ";;
        26) label="ⵟ";;
        27) label="ⵄ";;
        28) label="ⵖ";;
        29) label="ⵥ";;
        30) label="ⴳⵯ";;
        31) label="ⴽⵯ";;
        32) label="ⵕ";;
    esac
    for file in $1/Dataset/train_data/$i/*.png; do
        filename=$(basename $file)
        echo "    \"$filename\": \"$label\"," >> $2/labels.json
    done
    for file in $1/Dataset/test_data/$i/*.png; do
        filename=$(basename $file)
        echo "    \"$filename\": \"$label\"," >> $3/labels.json
    done
done

# Remove the last comma from the labels.json files
sed -i '$ s/.$//' $2/labels.json
sed -i '$ s/.$//' $3/labels.json

# Close the labels.json files
echo "}" >> $2/labels.json
echo "}" >> $3/labels.json

# Move the images to the train and test directories
for i in {0..32}; do
    mv $1/Dataset/train_data/$i/*.png $2/images
    mv $1/Dataset/test_data/$i/*.png $3/images
done

echo "Done"

exit 0
