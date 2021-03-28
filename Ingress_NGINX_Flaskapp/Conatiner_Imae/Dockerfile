FROM python:3.8-slim

WORKDIR /app
COPY requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt --src /usr/local/src

COPY  flask_app.py  /app/flask_app.py

EXPOSE 5000
CMD ["python", "/app/flask_app.py"]
