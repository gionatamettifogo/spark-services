# vLLM for Qwen3-VL on DGX Spark

Serve **Qwen3-VL-30B-A3B-Instruct** on NVIDIA DGX Spark (Blackwell GB10).

Based on [avarok/vllm-dgx-spark](https://huggingface.co/Avarok/vllm-dgx-spark).

## Quick Start

```bash
./serve.sh
```

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `MODEL` | `Qwen/Qwen3-VL-30B-A3B-Instruct` | Model to serve |
| `PORT` | `8001` | Server port |
| `GPU_MEMORY_UTILIZATION` | `0.8` | GPU memory (0-1) |
| `VLLM_API_KEY` | *(empty)* | API key for auth |

## Examples

```bash
# With API key
VLLM_API_KEY=your-key ./serve.sh

# Different model
MODEL=Qwen/Qwen2.5-VL-7B-Instruct ./serve.sh
```

## Test (Vision)

```bash
curl http://localhost:8001/v1/chat/completions \
    -H "Content-Type: application/json" \
    -d '{
        "model": "Qwen/Qwen3-VL-30B-A3B-Instruct",
        "messages": [{
            "role": "user",
            "content": [
                {"type": "text", "text": "What is in this image?"},
                {"type": "image_url", "image_url": {"url": "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Cat03.jpg/1200px-Cat03.jpg"}}
            ]
        }],
        "max_tokens": 200
    }'
```

## Build

```bash
./build-and-push.sh
```

## Credits

- [avarok/vllm-dgx-spark](https://huggingface.co/Avarok/vllm-dgx-spark) by [@Avarok](https://huggingface.co/Avarok)
- [Qwen3-VL-30B-A3B-Instruct](https://huggingface.co/Qwen/Qwen3-VL-30B-A3B-Instruct) by Alibaba
