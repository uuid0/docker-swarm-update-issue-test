FROM python:3.11.1-slim-bullseye

WORKDIR /opt/test
COPY marker marker
COPY container.py container.py

ENTRYPOINT ["python", "/opt/test/container.py"]