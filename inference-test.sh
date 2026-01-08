# Usage:
#   export LLM_API_KEY=xxx
#   export EMBED_API_KEY=xxx
#   ./quick-test.sh

echo -e "\n\nTesting LLM Capabilities..."
curl -s http://localhost:8001/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer very-secret-key-to-be-replaced" \
  -d '{
    "model":"Qwen/Qwen3-VL-30B-A3B-Instruct-FP8",
    "messages":[{"role":"user","content":"What is the difference between serotonin and melatonin?"}],
    "max_tokens":600
  }'

echo -e "\n\nTesting VLM Capabilities..."
curl -s http://localhost:8001/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer very-secret-key-to-be-replaced" \
  -d '{
    "model": "Qwen/Qwen3-VL-30B-A3B-Instruct-FP8",
    "messages": [
      {
        "role": "user",
        "content": [
          {
            "type": "text",
            "text": "What is in this image?"
          },
          {
            "type": "image_url",
            "image_url": {
              "url": "https://avatars.githubusercontent.com/u/9919?s=200&v=4"
            }
          }
        ]
      }
    ],
    "max_tokens": 300
  }'



# test embedding model
echo -e "\n\nTesting Embedding Capabilities..."
curl -s http://localhost:8002/v1/embeddings \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer very-secret-key-to-be-replaced" \
  -d '{
    "model": "Qwen/Qwen3-Embedding-0.6B",
    "input": [
      "hello world",
      "ciao mondo"
    ]
  }'
