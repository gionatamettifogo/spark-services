#!/bin/bash
# Serve Qwen3-VL-30B-A3B-Instruct using vLLM on DGX Spark
# Image: gionata/spark-vllm-qwen3vl (based on avarok/vllm-dgx-spark)

DOCKER_IMAGE="gionata/spark-vllm-qwen3vl:latest"

# Configuration via environment variables (optional overrides)
# MODEL - default: Qwen/Qwen3-VL-30B-A3B-Instruct
# PORT - default: 8001
# GPU_MEMORY_UTILIZATION - default: 0.8
# VLLM_API_KEY - default: (none)

docker run --rm -it \
    --gpus all \
    --ipc=host \
    -p ${PORT:-8001}:${PORT:-8001} \
    -e MODEL="${MODEL:-Qwen/Qwen3-VL-30B-A3B-Instruct}" \
    -e PORT="${PORT:-8001}" \
    -e GPU_MEMORY_UTILIZATION="${GPU_MEMORY_UTILIZATION:-0.8}" \
    ${VLLM_API_KEY:+-e VLLM_API_KEY="$VLLM_API_KEY"} \
    -v ~/.cache/huggingface:/root/.cache/huggingface \
    ${DOCKER_IMAGE}

# Usage examples:
#
# Default settings:
#   ./serve.sh
#
# With API key:
#   VLLM_API_KEY=your-key ./serve.sh
#
# With different model:
#   MODEL=Qwen/Qwen2.5-VL-7B-Instruct ./serve.sh
#
# With different port:
#   PORT=8080 ./serve.sh
#
# Combined:
#   MODEL=Qwen/Qwen2.5-VL-7B-Instruct PORT=8080 VLLM_API_KEY=secret ./serve.sh
