## Generate training data for the model

# Generate a dictionary from the corpus/ directory
# One word per line
echo "Generating dictionary..."
mkdir -p dict
cat corpus/*/* | tr ' ' '\n' | sort | uniq > dict/corpus_dict.txt

# Clean dictionary
echo "Cleaning dictionary..."
python clean_dict.py dict/corpus_dict.txt dict/corpus_dict_clean.txt tamazight

echo "Generating training data..."
trdg -c 10000 -w 1 -t 2 -f 50 -k 2 -rk -bl 1 -rbl -tc '#000000,#888888' -na 2 -fd fonts/ -dt dict/corpus_dict_clean.txt --output_dir gen_train
echo "Generating validation data..."
trdg -c 2000 -w 1 -t 2 -f 50 -k 2 -rk -bl 1 -rbl -tc '#000000,#888888' -na 2 -fd fonts/ -dt dict/corpus_dict_clean.txt --output_dir gen_val

# Use format used by the doctr library
echo "Converting to doctr format..."

mkdir -p gen_train/images; mv gen_train/*.jpg gen_train/images
mkdir -p gen_val/images; mv gen_val/*.jpg gen_val/images

./labels_txt_to_json.sh gen_train/labels.txt gen_train/labels.json; rm gen_train/labels.txt
./labels_txt_to_json.sh gen_val/labels.txt gen_val/labels.json; rm gen_val/labels.txt

# Clone the Tifinagh-MNIST repo and convert it to the doctr format
echo "Converting Tifinagh-MNIST to doctr format..."
git clone https://github.com/iseddik/Tifinagh-MNIST
./convert_tifinagh_mnist_to_doctr_format.sh Tifinagh-MNIST Tifinagh-MNIST-train Tifinagh-MNIST-val

# Concatenate the datasets
echo "Concatenating datasets..."
./concatenate_datasets.sh gen_train Tifinagh-MNIST-train train
./concatenate_datasets.sh gen_val Tifinagh-MNIST-val val

echo "Done"

exit 0
