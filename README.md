# ที่โฟลเดอร์ที่ต้องการ
mkdir flask-app; cd flask-app

# สร้าง venv
python -m venv venv
.\venv\Scripts\Activate.ps1

# โครงโฟลเดอร์ตามภาพ
mkdir config, libs\common, services\api

2) สร้างไฟล์หลัก
2.1 services/api/app.py
2.2 wsgi.py
2.3 config/settings.py
2.4 libs/common/utils.py
2.5 requirements.txt
2.6 .env 
2.7 .dockerignore
2.8 Dockerfile
2.9 docker-compose.yml
2.10 README.md

3) ติดตั้งไลบรารี + รันทดสอบ (ไม่ใช้ Docker)
pip install -r requirements.txt
python -m flask --app services.api.app run

4) รันด้วย Docker / Docker Compose (เหมือน prod)


5) Push ไป NIPA Registry


