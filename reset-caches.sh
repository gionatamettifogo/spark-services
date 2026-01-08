#!/bin/bash
#
# reset-caches.sh
#
# Clears vLLM, Triton, and related caches that may become stale after
# system/driver updates. Useful when experiencing stuck requests or
# garbage output under concurrent load.
#

set -e

echo "=== vLLM Cache Reset Script ==="
echo ""

# Step 1: Stop containers
echo "1. Stopping spark-services containers..."
docker compose -f "$(dirname "$0")/docker-compose.yaml" down 2>/dev/null || true
echo "   Done."

# Step 2: Clear Triton cache (compiled kernels)
echo ""
echo "2. Clearing Triton cache (~/.triton/cache)..."
if [ -d "$HOME/.triton/cache" ]; then
    rm -rf "$HOME/.triton/cache"
    echo "   Removed ~/.triton/cache"
else
    echo "   No Triton cache found, skipping."
fi

# Step 3: Clear vLLM model info cache
echo ""
echo "3. Clearing vLLM model info cache (~/.cache/vllm)..."
if [ -d "$HOME/.cache/vllm" ]; then
    rm -rf "$HOME/.cache/vllm"
    echo "   Removed ~/.cache/vllm"
else
    echo "   No vLLM cache found, skipping."
fi

# Step 4: Clear torch compile cache
echo ""
echo "4. Clearing Torch cache (~/.cache/torch)..."
if [ -d "$HOME/.cache/torch" ]; then
    rm -rf "$HOME/.cache/torch"
    echo "   Removed ~/.cache/torch"
else
    echo "   No Torch cache found, skipping."
fi

# Step 5: Clear any __pycache__ in huggingface modules (can get stale)
echo ""
echo "5. Clearing HuggingFace modules cache (~/.cache/huggingface/modules)..."
if [ -d "$HOME/.cache/huggingface/modules" ]; then
    rm -rf "$HOME/.cache/huggingface/modules"
    echo "   Removed ~/.cache/huggingface/modules"
else
    echo "   No HuggingFace modules cache found, skipping."
fi

echo ""
echo "=== Cache clearing complete ==="
echo ""
echo "You can now restart the services with:"
echo "  docker compose up -d"
echo ""
echo "Or pull the latest image first (recommended after driver updates):"
echo "  docker pull nvcr.io/nvidia/vllm:25.12.post1-py3"
echo "  docker compose up -d"
