# ---------- Base ----------
FROM python:3.13-slim AS base
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1
WORKDIR /app

# system deps (ถ้าต้องติดตั้งเพิ่ม ใส่ที่นี่)
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl ca-certificates && rm -rf /var/lib/apt/lists/*

# ---------- Builder ----------
FROM base AS builder
COPY requirements.txt .
RUN python -m pip install --upgrade pip && pip wheel --no-cache-dir -r requirements.txt -w /wheels

# ---------- Runtime ----------
FROM base AS runtime
COPY --from=builder /wheels /wheels
RUN pip install --no-cache /wheels/* && rm -rf /wheels
COPY . /app

# ใช้ gunicorn เสถียรกว่า flask dev server
ENV APP_HOST=0.0.0.0 APP_PORT=8000 APP_WORKERS=2 APP_LOG_LEVEL=info
EXPOSE 8000
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD curl -fsS http://127.0.0.1:8000/healthz || exit 1

# gunicorn entrypoint
CMD ["gunicorn", "-w", "2", "-b", "0.0.0.0:8000", "-k", "gthread", \
     "--log-level", "info", "services.api.wsgi:app"]
