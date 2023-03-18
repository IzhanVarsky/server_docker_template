import torch

if __name__ == '__main__':
    print("The program is running...")
    gpu_available = torch.cuda.is_available()
    print(f"GPU is available: {gpu_available}")
