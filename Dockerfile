FROM nvcr.io/nvidia/cuda:12.1.0-cudnn8-runtime-ubuntu22.04

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y git python3-pip cmake

RUN pip3 install torch==2.0.1 torchvision torchaudio --index-url https://download.pytorch.org/whl/cu117

COPY ./requirements.txt ./requirements.txt
WORKDIR .
RUN pip3 install -r ./requirements.txt

RUN pip3 uninstall -y opencv-python opencv-contrib-python opencv-python-headless opencv-contrib-python-headless
RUN pip3 install opencv-python-headless==4.8.0.74

ENTRYPOINT ["./entry.sh"]