## Generate training data for the model

echo "Generating training data..."
trdg -c 10000 -w 1 -t 2 -f 50 -k 2 -rk -bl 1 -rbl -tc '#000000,#888888' -na 2 -fd fonts/ -dt dict/corpus_ircam_unique.txt --output_dir train
echo "Generating validation data..."
trdg -c 2000 -w 1 -t 2 -f 50 -k 2 -rk -bl 1 -rbl -tc '#000000,#888888' -na 2 -fd fonts/ -dt dict/corpus_ircam_unique.txt --output_dir val

# Use format used by the doctr library
echo "Converting to doctr format..."

mkdir -p train/images; mv train/*.jpg train/images
mkdir -p val/images; mv val/*.jpg val/images

./labels_txt_to_json.sh train/labels.txt train/labels.json; rm train/labels.txt
./labels_txt_to_json.sh val/labels.txt val/labels.json; rm val/labels.txt
