#!/bin/bash
# Entrypoint script for Qwen3-VL vLLM server

set -e

# Build the command with required arguments
CMD="vllm serve \"${MODEL}\" \
    --dtype auto \
    --port ${PORT} \
    --host 0.0.0.0 \
    --enforce-eager \
    --gpu-memory-utilization ${GPU_MEMORY_UTILIZATION}"

# Add reasoning parser for Thinking models
if [[ "${MODEL}" == *"Thinking"* ]]; then
    # Use deepseek_r1 parser as it handles implicit opening <think> tags better than the qwen3 parser
    CMD="${CMD} --reasoning-parser deepseek_r1"
fi

# Add API key if provided
if [ -n "${VLLM_API_KEY}" ]; then
    CMD="${CMD} --api-key ${VLLM_API_KEY}"
fi

# Execute the command
echo "Starting vLLM server..."
echo "Model: ${MODEL}"
echo "Port: ${PORT}"
echo "GPU Memory Utilization: ${GPU_MEMORY_UTILIZATION}"
if [ -n "${VLLM_API_KEY}" ]; then
    echo "API Key: [configured]"
else
    echo "API Key: [not configured]"
fi

exec bash -c "${CMD}"
