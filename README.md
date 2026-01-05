# Spark Services: Qwen3-VL & Qwen3-Embedding

This repository hosts **Qwen3-VL-30B-A3B-Instruct** (Vision Language Model) and **Qwen3-Embedding-0.6B** services running on NVIDIA DGX Spark (Blackwell GB10).

Both services run as OpenAI-compatible APIs using [vLLM](https://github.com/vllm-project/vllm) via Docker Compose.

## Services

| Service | Model | Port | Description |
|---------|-------|------|-------------|
| **vllm-qwen3-vl** | `Qwen/Qwen3-VL-30B-A3B-Instruct-FP8` | `8001` | Vision-Language Model for chat and image understanding. |
| **vllm-qwen3-embed** | `Qwen/Qwen3-Embedding-0.6B` | `8002` | Text Embedding model for vector representation. |

## Quick Start

### 1. Start Services
To start both services in the background:
```bash
docker compose up -d
```
*Note: The first run will download model weights, which may take several minutes.*

### 2. Check Status
View running containers and health status:
```bash
docker compose ps
```
Wait until the status changes from `(health: starting)` to `(healthy)`.

### 3. View Logs
To see logs for a specific service (e.g., the vision model):
```bash
docker compose logs -f vllm-qwen3-vl
```

### 4. Stop Services
To stop and remove containers:
```bash
docker compose down
```

## Testing

See **[`inference-test.sh`](file:///home/developer/github/spark-services/inference-test.sh)** for examples on how to interact with the OpenAI-compatible APIs.

Basic usage examples:

```bash
# Run the test script
./inference-test.sh
```

The script demonstrates:
- Chat completions with image inputs (Vision)
- Generating text embeddings
- Handling authentication headers
