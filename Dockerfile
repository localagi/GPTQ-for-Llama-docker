# Pytorch version requires cuda 11.7
FROM nvidia/cuda:11.7.1-devel-ubuntu22.04

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends git build-essential python3 python3-pip python3-dev

RUN --mount=type=cache,target=/root/.cache/pip,sharing=locked \
    pip install --no-cache-dir --upgrade pip

RUN pip uninstall -y quant-cuda

WORKDIR /gptq-for-llama
COPY . .

RUN --mount=type=cache,target=/root/.cache/pip,sharing=locked \
    pip install -r requirements.txt

ARG TORCH_CUDA_ARCH_LIST=
RUN python3 setup_cuda.py install

ENTRYPOINT ["python3"]
