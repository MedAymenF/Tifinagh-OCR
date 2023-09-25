# Tifinagh-OCR

## Usage
First, we generate the training data by running the following command:

```./generate_training_data.sh```

Then, we train the model by running the following command:

```python train_pytorch.py crnn_mobilenet_v3_large --train_path train --val_path val -j 2 --pretrained --vocab tamazight --epochs 15 --name crnn_mobilenet_v3_large_printed --wb```

## Results
Run summary:

- exact_match 99.8%

- partial_match 99.85%

- val_loss 0.00391

Check out [This notebook](doctr_recognition.ipynb) To use the model for inference.
