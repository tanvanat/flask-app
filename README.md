# Flask + Docker + NIPA Registry

# แอปของเราพัฒนาโดยใช้ Flask บรรจุเป็น Docker container และเผยแพร่บน NIPA Registry

แอปนี้พัฒนาโดยใช้ **Flask**, แพ็กเป็น **Docker container**, และเผยแพร่บน **NIPA Registry**
เข้าทดสอบได้ที่ `http://localhost:8000`

---

## Endpoints (3 เส้นทางหลัก)

| Method | Path       | อธิบายสั้น ๆ           |
| -----: | ---------- | ---------------------- |
|  `GET` | `/`        | หน้าหลัก / ตัวอย่าง    |
|  `GET` | `/greet`   | ส่งข้อความทักทาย       |
|  `GET` | `/healthz` | เช็กสุขภาพแอป (200 OK) |

ตัวอย่างทดสอบ:

```bash
curl http://localhost:8000/
curl http://localhost:8000/greet
curl http://localhost:8000/healthz
```

---

## โครงสร้างโปรเจ็กต์

```
flask-app/
├─ config/
│  └─ settings.py
├─ libs/
│  └─ common/
│     └─ utils.py
├─ services/
│  └─ api/
│     └─ app.py
├─ venv/                    # virtual env (ไม่ต้อง commit)
├─ .env
├─ .dockerignore
├─ Dockerfile
├─ docker-compose.yml
├─ requirements.txt
└─ README.md
```

---

## 1) สร้างโปรเจ็กต์ (ครั้งแรก)

```powershell
# ไปยังโฟลเดอร์ที่ต้องการ
mkdir flask-app; cd flask-app

# สร้างและเปิดใช้งาน venv
python -m venv venv
.\venv\Scripts\Activate.ps1

# โครงโฟลเดอร์ตามภาพ
mkdir config, libs\common, services\api
```

จากนั้นสร้างไฟล์หลักให้ครบ:

* `services/api/app.py`
* `wsgi.py`
* `config/settings.py`
* `libs/common/utils.py`
* `requirements.txt`
* `.env`
* `.dockerignore`
* `Dockerfile`
* `docker-compose.yml`
* `README.md`

> *หมายเหตุ:* เนื้อหาไฟล์สามารถยึดตามตัวอย่างที่เตรียมไว้ในบทสนทนาก่อนหน้า

---

## 2) ติดตั้งไลบรารี & รันทดสอบ (โหมดพัฒนา — ไม่ใช้ Docker)

```powershell
pip install -r requirements.txt
python -m flask --app services.api.app run
# เปิด http://localhost:5000 (หรือพอร์ตที่ Flask แจ้ง)
```

---

## 3) รันด้วย Docker / Docker Compose (โหมดใกล้โปรดักชัน)

```powershell
# อยู่ในโฟลเดอร์ flask-app
docker compose up --build
# เปิด http://localhost:8000
```

> ถ้าไฟล์ `docker-compose.yml` มี `version:` โดนเตือนว่า obsolete ให้ลบบรรทัดนั้นได้

---

## 4) Push ขึ้น NIPA Registry

```powershell
docker login registry.nipa.cloud

# (ถ้ายังไม่ build แยก ให้สร้างอิมเมจ)
docker buildx build --platform linux/amd64 -t registry.nipa.cloud/front-test/flask-api:1.0.0 .

# push
docker push registry.nipa.cloud/front-test/flask-api:1.0.0
```

---

## 5) สำหรับผู้ใช้คนอื่น (ดึงและรันทันที)

```bash
docker pull registry.nipa.cloud/front-test/flask-api:1.0.0

docker run -d -p 8000:8000 registry.nipa.cloud/front-test/flask-api:1.0.0
<<<<<<< HEAD
# แล้วเปิด http://localhost:8000
```

---
