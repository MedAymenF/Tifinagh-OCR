# Tifinagh-OCR

## Usage
First, we generate the training data by running the following command:

```./generate_training_data.sh```

Then, we train the model by running the following command:

```python train_pytorch.py crnn_mobilenet_v3_large --train_path train --val_path val -j 2 --pretrained --vocab tamazight --epochs 10 --name crnn_mobilenet_v3_large --wb```

## Results
Run summary:

- exact_match 99.45%

- partial_match 99.57%

- val_loss 0.00942

Check out [This notebook](doctr_recognition.ipynb) To use the model for inference.

## Hugging Face Space
Check out the domo on Hugging Face [![Hugging Face Spaces](https://img.shields.io/badge/%F0%9F%A4%97%20Hugging%20Face-Spaces-blue)](https://huggingface.co/spaces/ayymen/Tifinagh-OCR).